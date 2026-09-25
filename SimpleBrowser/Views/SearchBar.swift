//
//  SearchBar.swift
//  SimpleBrowser
//
//  Created by Lujain Almulaifi on 24/09/2026.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        HStack {
            Text("URL:")
            TextField("URl", text: $viewModel.urlString)
                .keyboardType(.URL)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
    }
}
