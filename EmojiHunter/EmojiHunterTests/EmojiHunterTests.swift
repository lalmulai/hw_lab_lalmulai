//
//  EmojiHunterTests.swift
//  EmojiHunterTests
//
//  Created by Lujain Almulaifi on 04/11/2026.
//

import Testing
@testable import EmojiHunter

@MainActor
struct GameViewModelTests {

    // A new game should start in the searching state at level 0
    @Test func startingStateIsSearching() {
        let vm = GameViewModel()
        #expect(vm.emojiStatus == .searching)
        #expect(vm.currentLevel == 0)
        #expect(vm.timeRemaining == GameViewModel.roundDuration)
    }

    // Each tick should lower the time by 1 while searching
    @Test func adjustTimeDecrementsWhileSearching() {
        let vm = GameViewModel()
        let startingTime = vm.timeRemaining
        vm.adjustTime()
        #expect(vm.timeRemaining == startingTime - 1)
    }

    // At 0 seconds the emoji should be marked not found
    @Test func adjustTimeMarksNotFoundWhenTimeExpires() {
        let vm = GameViewModel()
        vm.timeRemaining = 0
        vm.adjustTime()
        #expect(vm.emojiStatus == .notFound)
        #expect(vm.showNext == true)
    }

    // When found, the time should reset to the full round time
    @Test func adjustTimeResetsWhenFound() {
        let vm = GameViewModel()
        vm.emojiStatus = .found
        vm.timeRemaining = 3
        vm.adjustTime()
        #expect(vm.timeRemaining == GameViewModel.roundDuration)
    }

    // startSearch should move to the next level
    @Test func startSearchAdvancesLevel() {
        let vm = GameViewModel()
        let starting = vm.currentLevel
        vm.startSearch()
        if starting < emojiObjects.count - 1 {
            #expect(vm.currentLevel == starting + 1)
            #expect(vm.emojiStatus == .searching)
        }
    }

    // restartGame should go back to level 0 and searching
    @Test func restartGameResetsLevel() {
        let vm = GameViewModel()
        vm.currentLevel = 3
        vm.restartGame()
        #expect(vm.currentLevel == 0)
        #expect(vm.emojiStatus == .searching)
    }
}
