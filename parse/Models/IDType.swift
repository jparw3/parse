//
//  IDType.swift
//  parse
//
//  Created by Jack Willars on 16/11/2024.
//

enum IDType: String, CaseIterable {
    case uuid = "UUID/GUID"
    case email = "Email Address"
    case phone = "Phone Number"
    case mongoDBId = "MongoDB ObjectID"
    case jwtToken = "JWT Token"
    case ipv4 = "IPv4 Address"
    case ipv6 = "IPv6 Address"

    
    var pattern: String {
        switch self {
        case .uuid:
            return "^[0-9a-fA-F]{8}-?[0-9a-fA-F]{4}-?[0-9a-fA-F]{4}-?[0-9a-fA-F]{4}-?[0-9a-fA-F]{12}$"
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .phone:
            return "^\\+?[1-9]\\d{1,14}$"
        case .mongoDBId:
            return "^[0-9a-fA-F]{24}$"
        case .jwtToken:
            return "^[A-Za-z0-9-_=]+\\.[A-Za-z0-9-_=]+\\.[A-Za-z0-9-_.+/=]*$"
        case .ipv4:
            return "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
        case .ipv6:
            return "^(?:[A-F0-9]{1,4}:){7}[A-F0-9]{1,4}$"
        }
    }
    
    var description: String {
        switch self {
        case .uuid:
            return "Universally Unique Identifier"
        case .email:
            return "Email Address"
        case .phone:
            return "Phone Number (E.164 format)"
        case .mongoDBId:
            return "MongoDB ObjectID (24 hex chars)"
        case .jwtToken:
            return "JSON Web Token"
        case .ipv4:
            return "IPv4 Address"
        case .ipv6:
            return "IPv6 Address"
        }
    }
    
    var example: String {
        switch self {
        case .uuid:
            return "550e8400-e29b-41d4-a716-446655440000"
        case .email:
            return "example@domain.com"
        case .phone:
            return "+12125551234"
        case .mongoDBId:
            return "507f1f77bcf86cd799439011"
        case .jwtToken:
            return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIn0.dozjgNryP4J3jVmNHl0w5N_XgL0n3I9PlFUP0THsR8U"
        case .ipv4:
            return "192.168.1.1"
        case .ipv6:
            return "2001:0db8:85a3:0000:0000:8a2e:0370:7334"
        }
    }
}
