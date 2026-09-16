//
//  BookRowView.swift
//  BookManager
//
//  Created by Lujain Almulaifi on 16/09/2026.
//

import SwiftUI

struct BookRowView: View {
    var book: Book

    var body: some View {
        NavigationLink(
            destination: BookDetailView(book: book),
            label: {
                Text(book.title)
                    .fontWeight(.bold)
                    .font(.body)
            }
        )
    }
}
