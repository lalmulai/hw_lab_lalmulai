//
//  ContentView.swift
//  EmojiHunter
//
//  Created by Lujain Almulaifi on 04/11/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = GameViewModel()

    // Builds the camera or NEXT screen, plus the messages at the bottom
    var body: some View {
        ZStack {
            // Level 1: NEXT screen if found or not found (and not game over), otherwise the camera
            if (viewModel.showNext || viewModel.emojiStatus == .found) && viewModel.emojiStatus != .gameOver {
                Color.white
                    .ignoresSafeArea()
                Button(action: {
                    viewModel.startSearch()
                }) {
                    Text("NEXT")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.green)
                        .cornerRadius(10)
                }
            } else {
                // The $ passes a Binding so the camera screen can change emojiStatus
                CustomCameraRepresentable(emojiString: emojiObjects[viewModel.currentLevel].emojiName, emojiFound: $viewModel.emojiStatus)
                    .ignoresSafeArea()
            }

            // Level 2: messages at the bottom of the screen
            VStack {
                Spacer()

                if viewModel.emojiStatus == .gameOver {
                    Button(action: {
                        viewModel.restartGame()
                    }) {
                        Text("GAME OVER\nTap to restart")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                } else if viewModel.emojiStatus == .searching {
                    Text("\(viewModel.timeRemaining)")
                        .font(.system(size: 80, weight: .bold, design: .rounded))
                        .foregroundColor(.yellow)
                        .onReceive(viewModel.timer) { _ in
                            viewModel.adjustTime()
                        }
                }

                viewModel.emojiResultText()
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    ContentView()
}
