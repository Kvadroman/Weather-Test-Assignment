//
//  InvalidationError.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 15.06.2023.
//

import Foundation

struct InvalidationError: LocalizedError {
    var errorDescription: String? { message }
    private var message: String?
    
    init(_ message: String) {
        self.message = message
    }
    
    static let invalidCityName = InvalidationError("You enter invalid city name, please try again")
}

