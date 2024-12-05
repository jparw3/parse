import SwiftUI

struct MenuItemView: View {
    let icon: String
    let label: String
    let iconColor: Color
    let isSelected: Bool
    let action: () -> Void
    
    @State private var isHovered: Bool = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .frame(width: 24, height: 24)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [iconColor, iconColor.opacity(0.5)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                    )
                    .foregroundColor(.white)
                
                Text(label)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding(9)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(isSelected ? Color.gray.opacity(0.1) : (isHovered ? Color.gray.opacity(0.05) : Color.clear))
                    .animation(.easeInOut(duration: 0.2), value: isHovered)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
    }
}


#Preview {
    MenuItemView(
        icon: "moon.fill",
        label: "General",
        iconColor: .purple,
        isSelected: false
    ) {
        
    }
}
