//
//  IDValidator.swift
//  parse
//
//  Created by Jack Willars on 16/11/2024.
//

class IDValidator {
    static func validate(_ text: String) -> IdentifiedValue? {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        for type in IDType.allCases {
            if let _ = trimmedText.range(of: type.pattern, options: .regularExpression) {
                return IdentifiedValue(
                    type: type,
                    value: trimmedText,
                    matchedText: trimmedText
                )
            }
        }
        
        return nil
    }
    
    static func validateAll(_ text: String) -> [IdentifiedValue] {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        var results: [IdentifiedValue] = []
        
        for type in IDType.allCases {
            if let _ = trimmedText.range(of: type.pattern, options: .regularExpression) {
                results.append(IdentifiedValue(
                    type: type,
                    value: trimmedText,
                    matchedText: trimmedText
                ))
            }
        }
        
        return results
    }
}
