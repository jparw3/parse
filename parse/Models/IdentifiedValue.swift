//
//  IdentifiedValue.swift
//  parse
//
//  Created by Jack Willars on 16/11/2024.
//

struct IdentifiedValue {
    let type: IDType
    let value: String
    let matchedText: String
    
    var displayTitle: String {
        return "\(type.rawValue)"
    }
    
    var displayDescription: String {
        return type.description
    }
}
