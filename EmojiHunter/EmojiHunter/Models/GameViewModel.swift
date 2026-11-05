//
//  GameViewModel.swift
//  EmojiHunter
//
//  Created by Lujain Almulaifi on 04/11/2026.
//

import SwiftUI
import Observation
import Combine

@Observable
class GameViewModel {
    // MARK: - Properties setup
    static let roundDuration = 10
    var currentLevel = 0
    var showNext = false

    // Set up timer for the game
    @ObservationIgnored
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var timeRemaining = GameViewModel.roundDuration

    // Set initial emoji status to searching
    var emojiStatus = EmojiSearch.searching

    // MARK: - Timer methods

    // Creates a fresh timer that ticks every second
    func instantiateTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }

    // Stops the current timer
    func cancelTimer() {
        self.timer.upstream.connect().cancel()
    }

    // Runs every tick: counts down, or stops the timer if found, or marks not found at 0
    func adjustTime() {
        if self.emojiStatus == .found {
            self.cancelTimer()
            self.timeRemaining = Self.roundDuration
        }
        else {
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
            else {
                self.emojiStatus = .notFound
                self.showNext = true
            }
        }
    }

    // MARK: - Gameplay methods

    // Moves to the next emoji, or ends the game after the last one
    func startSearch() {
        if self.currentLevel == emojiObjects.count - 1 {
            self.emojiStatus = .gameOver
        }
        else {
            self.currentLevel = self.currentLevel + 1
            startRound()
        }
    }

    // Starts the whole game over from the first emoji
    func restartGame() {
        self.currentLevel = 0
        startRound()
    }

    // Resets the clock and status for a new round
    func startRound() {
        self.timeRemaining = Self.roundDuration
        self.emojiStatus = .searching
        self.showNext = false
        self.instantiateTimer()
    }

    // Builds the message shown at the bottom of the screen for the current status
       func emojiResultText() -> Text {
           switch emojiStatus {
           case .found:
               return Text("\(emojiObjects[currentLevel].emoji) is FOUND")
                   .font(.system(size: 50, design: .rounded))
                   .fontWeight(.bold)
                   .foregroundColor(.black)
           case .notFound:
               return Text("\(emojiObjects[currentLevel].emoji) NOT FOUND")
                   .font(.system(size: 50, design: .rounded))
                   .foregroundColor(.red)
                   .fontWeight(.bold)
           default:
               return Text(emojiObjects[currentLevel].emoji)
                   .font(.system(size: 50, design: .rounded))
                   .fontWeight(.bold)
                   .foregroundColor(.black)
           }
       }
}
