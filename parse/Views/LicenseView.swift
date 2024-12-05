//
//  LicenseView.swift
//  parse
//
//  Created by Jack Willars on 14/11/2024.
//

import SwiftUI

struct LicenseView: View {
    
    @State private var licenseKey: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HeaderView(title: "License", icon: "checkmark.seal.fill", color: .cyan)
                
                Divider()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        SettingsSection(title: "License") {
                            HStack {
                                Image(systemName: "key.fill")
                                    .foregroundColor(.primary)
                                
                                TextField("License Key", text: $licenseKey
                                )
                                .textFieldStyle(.plain)
                                .fontDesign(.monospaced)
                                
                                Button(action: {
                                    
                                }) {
                                    Image(systemName: "arrow.right")
                                }
                                .buttonStyle(ParseButtonStyle())
                                .frame(width: 14, height: 14)
                                
                                .padding(.trailing, 4)
                                
                            }
                            .padding(14)
                            .background(
                                Color.clear
                            )
                        }
                        .frame(width: geometry.size.width - 22)
                        
                        SettingsSection(title: "Trial") {
                            HStack {
                                Image(systemName: "clock.fill").foregroundStyle(Color.accentColor)
                                Text("Time remaining")
                                Spacer()
                                Text("1d 23h 58m 33s").opacity(0.7)
                            }
                            .padding(14)
                        }
                        .frame(width: geometry.size.width - 22)
                    }
                }
                .padding(11)
            }
        }
    }
}

#Preview {
    LicenseView()
}
