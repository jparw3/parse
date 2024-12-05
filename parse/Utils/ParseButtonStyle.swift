//
//  ParseButtonStyle.swift
//  parse
//
//  Created by Jack Willars on 14/11/2024.
//


import SwiftUI

struct ParseButtonStyle: ButtonStyle {

    @State private var isHovering = false

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
              configuration
                .label
                .foregroundColor(.white.opacity(0.8))
                .fontWeight(.bold)
                .padding(8)
                .background(isHovering ? Color.gray.opacity(0.15) : Color.gray.opacity(0.05))
                .cornerRadius(10)
                .overlay(
                  RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .scaleEffect(configuration.isPressed ? 0.95 : isHovering ? 1.02 : 1.0)
                .animation(.spring(), value: configuration.isPressed)
                .onHover(perform: { hovering in
                  withAnimation {
                    isHovering = hovering
                  }
                })
            }
    }
}

extension View {
    func hoverButtonStyle() -> some View {
        self.buttonStyle(ParseButtonStyle())
    }
}
