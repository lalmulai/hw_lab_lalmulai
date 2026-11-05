//
//  Coordinator.swift
//  EmojiHunter
//
//  Created by Lujain Almulaifi on 04/11/2026.
//

import Foundation
import SwiftUI

// Receives "emoji found" from the camera screen and updates the game status
class Coordinator: NSObject, EmojiFoundDelegate {
    @Binding var emojiFound: EmojiSearch

    // Stores the binding to the game status
    init(emojiFound: Binding<EmojiSearch>) {
        _emojiFound = emojiFound
    }

    // Called by the camera screen when the emoji is recognized
    func emojiWasFound(result: Bool) {
        print("emojiWasFound \(result)")
        emojiFound = .found
    }
}
