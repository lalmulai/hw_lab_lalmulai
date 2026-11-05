//
//  CustomCameraRepresentable.swift
//  EmojiHunter
//
//  Created by Lujain Almulaifi on 04/11/2026.
//

import Foundation
import SwiftUI

// Lets SwiftUI show our UIKit camera screen
struct CustomCameraRepresentable: UIViewControllerRepresentable {
    var emojiString: String
    @Binding var emojiFound: EmojiSearch

    // Creates the camera screen and connects its delegate
    func makeUIViewController(context: Context) -> CameraViewController {
        let controller = CameraViewController(emoji: emojiString)
        controller.delegate = context.coordinator
        return controller
    }

    // Nothing to update after creation
    func updateUIViewController(_ cameraViewController: CameraViewController, context: Context) {}

    // Creates the coordinator that passes results back to SwiftUI
    func makeCoordinator() -> Coordinator {
        Coordinator(emojiFound: $emojiFound)
    }
}
