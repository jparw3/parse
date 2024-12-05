//
//  PermissionsService.swift
//  parse
//
//  Created by Jack Willars on 16/11/2024.
//

import Cocoa

final class PermissionsService: ObservableObject {
    @Published var isTrusted: Bool = AXIsProcessTrusted()

    static func checkAccessibility() -> Bool {
        let isEnabled = AXIsProcessTrusted()
        print("🔑 PermissionsService: Accessibility enabled: \(isEnabled)")
        return isEnabled
    }

    func pollAccessibilityPrivileges() {
        print("👀 PermissionsService: Starting permission polling")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isTrusted = AXIsProcessTrusted()
            print("🔄 PermissionsService: Polling - Accessibility enabled: \(self.isTrusted)")
            
            if !self.isTrusted {
                self.pollAccessibilityPrivileges()
            } else {
                print("✅ PermissionsService: Accessibility permissions granted")
            }
        }
    }

    static func requestAccessibility() {
        print("🔐 PermissionsService: Requesting accessibility permissions")
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
        AXIsProcessTrustedWithOptions(options)
    }
}
