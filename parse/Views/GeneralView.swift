//
//  GeneralVuew.swift
//  parse
//
//  Created by Jack Willars on 14/11/2024.
//

import SwiftUI

struct GeneralView: View {
    @State private var startOnLogin: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HeaderView(title: "General", icon: "gearshape.fill", color: .gray)
                
                Divider()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        SettingsSection(title: "System") {
                            HStack {
                                Text("Launch at login")
                                    .font(.body)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Toggle("", isOn: $startOnLogin)
                                    .toggleStyle(SwitchToggleStyle())
                                    .labelsHidden()
                            }
                            .padding(14)
                            ContentDivider()
                            HStack {
                                Text("idk")
                                    .font(.body)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Toggle("", isOn: $startOnLogin)
                                    .toggleStyle(SwitchToggleStyle())
                                    .labelsHidden()
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

