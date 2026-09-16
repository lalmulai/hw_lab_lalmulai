//
//  LibraryView.swift
//  BookManager
//
//  Created by Lujain Almulaifi on 16/09/2026.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var library: Library

    var body: some View {
        NavigationView {
            List {
                ForEach(library.books) { book in
                    BookRowView(book: book)
                }
                .onDelete(perform: removeRows)
            }
            .navigationBarTitle("Library")
        }
    }

    func removeRows(at offsets: IndexSet) {
        library.books.remove(atOffsets: offsets)
    }
}

#Preview {
    LibraryView()
        .environmentObject(Library())
}
