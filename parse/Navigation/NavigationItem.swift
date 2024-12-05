import SwiftUI

enum NavigationItem: String, CaseIterable {
    case general
    case license
    case about
    
    var icon: String {
        switch self {
        case .general: return "gearshape.fill"
        case .license: return "checkmark.seal.fill"
        case .about: return "info.circle"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .general: return .gray
        case .license: return .cyan
        case .about: return .gray
        }
    }
    
    var label: String {
        self.rawValue.capitalized
    }
}
