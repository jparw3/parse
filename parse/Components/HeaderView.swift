//
//  HeaderView.swift
//  parse
//
//  Created by Jack Willars on 14/11/2024.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .frame(width: 24, height: 24)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [color, color.opacity(0.5)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                )
                .foregroundColor(.white)
            
            Text(title)
                .font(.title2)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding(11)
    }
}
