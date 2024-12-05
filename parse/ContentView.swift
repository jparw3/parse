//
//  ContentView.swift
//  parse
//
//  Created by Jack Willars on 14/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedItem: NavigationItem = .general
    
    private var windowHeight: CGFloat = 630;
    private var windowWidth: CGFloat = 221
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                ForEach(NavigationItem.allCases, id: \.self) { item in
                    MenuItemView(
                        icon: item.icon,
                        label: item.label,
                        iconColor: item.iconColor,
                        isSelected: selectedItem == item
                    ) {
                        selectedItem = item
                    }
                }
                Spacer()
            }
            .padding(11)
            .frame(width: 221)
            
            Divider()
            
            VStack {
                switch selectedItem {
                case .general:
                    GeneralView()
                case .license:
                    LicenseView()
                case .about:
                    Text("Notifications View")
                }
                Spacer()
            }
            .frame(width: 400)
        }
        .background(VisualEffectView().ignoresSafeArea())
    }
}


#Preview {
    ContentView()
}
