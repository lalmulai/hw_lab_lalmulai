//
//  Flashcard.swift
//  RailsCards
//
//  Created by Lujain Almulaifi on 12/09/2026.
//

import Foundation


struct Flashcard {
    var command: String
    var definition: String
    
    init(command: String, definition: String) {
        self.command = command
        self.definition = definition
    }
}
