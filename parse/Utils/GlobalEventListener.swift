import Cocoa

class GlobalEventListener {
    private var eventMonitor: Any?
    
    init() {
        print("🎯 GlobalEventListener: Initializing...")
        setupMouseEventMonitor()
    }
    
    private func setupMouseEventMonitor() {
        eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown) { [weak self] event in
            print("👆 Click detected")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self?.handleClick()
            }
        }
    }
    
    private func handleClick() {
        let systemWide = AXUIElementCreateSystemWide()
        var element: AXUIElement?
        
        // Get the element under the mouse
        let point = NSEvent.mouseLocation
        let screenPosition = CGPoint(x: point.x, y: CGFloat(NSScreen.main?.frame.height ?? 0) - point.y)
        
        AXUIElementCopyElementAtPosition(systemWide, Float(screenPosition.x), Float(screenPosition.y), &element)
        
        guard let focusedElement = element else {
            print("❌ No element found at position")
            return
        }
        
        // Get the visible character range
        var visibleRangeRef: CFTypeRef?
        AXUIElementCopyAttributeValue(focusedElement, kAXVisibleCharacterRangeAttribute as CFString, &visibleRangeRef)
        
        guard let visibleRangeValue = visibleRangeRef else {
            print("❌ Could not get visible range")
            return
        }
        
        var visibleRange = CFRange()
        AXValueGetValue(visibleRangeValue as! AXValue, .cfRange, &visibleRange)
        
        // Create a range value for the entire visible text
        var fullRange = CFRange(location: visibleRange.location, length: visibleRange.length)
        guard let rangeValue = AXValueCreate(.cfRange, &fullRange) else {
            print("❌ Could not create range value")
            return
        }
        
        // Get the text for this range
        var textValue: CFTypeRef?
        AXUIElementCopyParameterizedAttributeValue(
            focusedElement,
            kAXStringForRangeParameterizedAttribute as CFString,
            rangeValue as CFTypeRef,
            &textValue
        )
        
        guard let fullText = textValue as? String else {
            print("❌ Could not get text")
            return
        }
        
        print("📝 Raw full text: '\(fullText)'")
        
        // Select the entire text
        AXUIElementSetAttributeValue(
            focusedElement,
            kAXSelectedTextRangeAttribute as CFString,
            rangeValue as CFTypeRef
        )
        
        // Check if it's a valid ID
        if let match = IDValidator.validate(fullText) {
            print("✅ Found match!")
            print("📋 Type: \(match.type.rawValue)")
            print("📋 Value: \(match.value)")
        }
    }
    
    private func selectText(element: AXUIElement, range: NSRange) {
        var cfRange = CFRange(location: range.location, length: range.length)
        guard let rangeValue = AXValueCreate(.cfRange, &cfRange) else {
            print("❌ Could not create range value")
            return
        }
        
        let result = AXUIElementSetAttributeValue(
            element,
            kAXSelectedTextRangeAttribute as CFString,
            rangeValue as CFTypeRef
        )
        
        if result != .success {
            print("❌ Could not set selection: \(result)")
        }
    }
    
    private func getTextBlock(at index: String.Index, in text: String) -> String {
        var start = text.startIndex
        if index > text.startIndex {
            for i in (0..<text.distance(from: text.startIndex, to: index)).reversed() {
                let currentIndex = text.index(text.startIndex, offsetBy: i)
                if text[currentIndex] == " " {
                    start = text.index(after: currentIndex)
                    break
                }
            }
        }
        
        var end = text.endIndex
        if index < text.endIndex {
            for i in text.distance(from: text.startIndex, to: index)..<text.count {
                let currentIndex = text.index(text.startIndex, offsetBy: i)
                if text[currentIndex] == " " {
                    end = currentIndex
                    break
                }
            }
        }
        
        return String(text[start..<end])
    }
    
    private func getFullText(_ element: AXUIElement) -> String? {
        let attributes = [
            kAXValueAttribute,
            kAXSelectedTextAttribute,
            kAXTitleAttribute,
            kAXDescriptionAttribute
        ]
        
        for attribute in attributes {
            var value: CFTypeRef?
            let result = AXUIElementCopyAttributeValue(element, attribute as CFString, &value)
            
            if result == .success,
               let stringValue = value as? String,
               !stringValue.isEmpty {
                print("✅ Found text using attribute: \(attribute)")
                return stringValue
            }
        }
        
        var attributes_array: CFArray?
        AXUIElementCopyAttributeNames(element, &attributes_array)
        
        if let attributes = attributes_array as? [String] {
            print("📝 Available attributes: \(attributes)")
        }
        
        return nil
    }
    
    private func getSelectedRange(_ element: AXUIElement) -> NSRange? {
        if let value = getAttributeValue(element, attribute: kAXSelectedTextRangeAttribute) {
            var range = CFRange()
            if AXValueGetValue(value as! AXValue, .cfRange, &range) {
                return NSRange(location: range.location, length: range.length)
            }
        }
        return nil
    }
    
    private func getFocusedElement() -> AXUIElement? {
        let systemWideElement = AXUIElementCreateSystemWide()
        var focusedElement: CFTypeRef?
        let result = AXUIElementCopyAttributeValue(systemWideElement, kAXFocusedUIElementAttribute as CFString, &focusedElement)
        
        if result == .success {
            print("✅ Found focused element")
            return (focusedElement as! AXUIElement)
        } else {
            print("❌ Could not get focused element: \(result)")
            return nil
        }
    }
    
    private func getAttributeValue(_ element: AXUIElement, attribute: String) -> CFTypeRef? {
        var value: CFTypeRef?
        let result = AXUIElementCopyAttributeValue(element, attribute as CFString, &value)
        return result == .success ? value : nil
    }
}

extension String {
    func rangeOfWord(at index: String.Index) -> Range<String.Index> {
        let breakingCharacters = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        
        let start = self[..<index].lastIndex(where: { 
            String($0).rangeOfCharacter(from: breakingCharacters) != nil
        }) ?? startIndex
        
        let end = self[index...].firstIndex(where: { 
            String($0).rangeOfCharacter(from: breakingCharacters) != nil
        }) ?? endIndex
        
        let adjustedStart = start == startIndex ? start : self.index(after: start)
        
        return Range(uncheckedBounds: (adjustedStart, end))
    }
}
