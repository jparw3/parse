//
//  parseApp.swift
//  parse
//
//  Created by Jack Willars on 14/11/2024.
//

import SwiftUI

@main
struct parseApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var contentWindow: NSWindow?
    var globalEventListener: GlobalEventListener?
    private var permissionsService = PermissionsService()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupStatusItem()
        checkAndRequestAccessibility()
    }
    
    private func setupStatusItem() {
        let menu = createMenu()
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "cursorarrow.square.fill", accessibilityDescription: nil)
            button.image?.isTemplate = true
        }
        
        statusItem?.menu = menu
    }
    
    private func checkAndRequestAccessibility() {
        if PermissionsService.checkAccessibility() {
            print("Accessibility permissions granted")
            globalEventListener = GlobalEventListener()
        } else {
            print("Accessibility permissions needed")
            let alert = NSAlert()
            alert.messageText = "Accessibility Access Required"
            alert.informativeText = "Parse needs accessibility permissions to detect text under your cursor. Please grant access in System Settings > Privacy & Security > Accessibility."
            alert.alertStyle = .warning
            alert.addButton(withTitle: "Open System Settings")
            alert.addButton(withTitle: "Later")
            
            let response = alert.runModal()
            if response == .alertFirstButtonReturn {
                PermissionsService.requestAccessibility()
                // Start polling for permission changes
                permissionsService.pollAccessibilityPrivileges()
            }
        }
    }
    
    private func createMenu() -> NSMenu {
        let menu = NSMenu()
        menu.autoenablesItems = false
        menu.minimumWidth = 216
        
        menu.addItem(NSMenuItem(title: "Preferences...", action: #selector(showContentView), keyEquivalent: ","))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q"))
        
        let parseMenuItem = NSMenuItem(title: "Parse Text (⌥)", action: #selector(toggleParse), keyEquivalent: "")
        parseMenuItem.target = self
        menu.addItem(parseMenuItem)
        menu.addItem(NSMenuItem.separator())
        
        return menu
    }
    
    @objc func showContentView() {
        if contentWindow == nil {
            let contentView = ContentView()
                .toolbar {
                    Color.clear
                }
                .background(Color.clear)
            
            let hostingController = NSHostingController(rootView: contentView)
            
            contentWindow = NSWindow(contentViewController: hostingController)
            contentWindow?.setContentSize(NSSize(width: 600, height: 400))
            
            contentWindow?.title = "Parse - Preferences"
            contentWindow?.styleMask = [.titled, .closable, .fullSizeContentView]
            contentWindow?.titleVisibility = .hidden
            contentWindow?.titlebarAppearsTransparent = true
            contentWindow?.isReleasedWhenClosed = false
            
            contentWindow?.level = .floating
            
            if let screen = NSScreen.main {
                let screenFrame = screen.frame
                let windowFrame = contentWindow!.frame
                let x = screenFrame.midX - windowFrame.width / 2
                let y = screenFrame.midY - windowFrame.height / 2
                contentWindow?.setFrame(NSRect(x: x, y: y, width: windowFrame.width, height: windowFrame.height), display: true)
            }
            
            if let superview = hostingController.view.superview {
                hostingController.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    hostingController.view.topAnchor.constraint(equalTo: superview.topAnchor),
                    hostingController.view.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                    hostingController.view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                    hostingController.view.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
                ])
            }
        }
        
        contentWindow?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.contentWindow?.level = .normal
        }
    }
    
    @objc func quitApp() {
        NSApp.terminate(nil)
    }
    
    @objc func toggleParse() {
        if let statusItem = statusItem {
            statusItem.button?.highlight(true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                statusItem.button?.highlight(false)
            }
        }
    }
}
