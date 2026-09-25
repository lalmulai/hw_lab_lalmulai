//
//  BottomBar.swift
//  SimpleBrowser
//
//  Created by Lujain Almulaifi on 24/09/2026.
//


import SwiftUI

struct BottomBar: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        HStack {
            Button(action: { self.viewModel.goBack() }) {
                Image(systemName: "chevron.left")
            } //button1 end

            Spacer()

            Button(action: { self.viewModel.goForward() }) {
                Image(systemName: "chevron.right")
            }

            Spacer()

            Button(action: { self.viewModel.share() }) {
                Image(systemName: "square.and.arrow.up")
            }

            Spacer()

            Button(action: { self.viewModel.refresh() }) {
                Image(systemName: "arrow.clockwise")
            }

            Spacer()

            Button(action: { self.viewModel.stop() }) {
                Image(systemName: "xmark")
            }
        }
    }
}
