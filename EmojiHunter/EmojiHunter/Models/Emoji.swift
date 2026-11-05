//
//  Emoji.swift
//  EmojiHunter
//
//  Created by Lujain Almulaifi on 04/11/2026.
//

import Foundation

// Tells the camera screen when the emoji was found
protocol EmojiFoundDelegate: AnyObject {
    func emojiWasFound(result: Bool)
}

// The possible states of the game
enum EmojiSearch {
    case found
    case notFound
    case searching
    case gameOver
}

// One emoji to hunt: the emoji itself and the name the ML model uses
struct EmojiModel: Identifiable {
    let id = UUID()
    var emoji: String
    var emojiName: String
}

// emojiName must appear in MobileNetV2's label, e.g. "laptop, laptop computer"
let emojiObjects: [EmojiModel] = [
    EmojiModel(emoji: "💻", emojiName: "laptop"),
    EmojiModel(emoji: "🖊️", emojiName: "ballpoint"),
    EmojiModel(emoji: "☕", emojiName: "coffee mug"),
    EmojiModel(emoji: "🎒", emojiName: "backpack"),
    EmojiModel(emoji: "📱", emojiName: "cellular telephone")
]
