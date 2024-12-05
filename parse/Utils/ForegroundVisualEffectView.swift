//
//  ForegroundVisualEffectView.swift
//  parse
//
//  Created by Jack Willars on 14/11/2024.
//

import SwiftUI

struct ForegroundVisualEffectView: NSViewRepresentable {

    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        
        view.blendingMode = .withinWindow
        view.state = .active
        view.material = .popover
        view.wantsLayer = true
        
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        //
    }
}
