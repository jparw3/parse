//
//  VisualEffectView.swift
//  parse
//
//  Created by Jack Willars on 14/11/2024.
//

import SwiftUI

struct VisualEffectView: NSViewRepresentable {

    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        
        view.blendingMode = .behindWindow
        view.state = .active
        view.material = .menu
        view.wantsLayer = true
        
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        //
    }
}
