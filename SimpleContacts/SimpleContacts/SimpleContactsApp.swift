//
//  SimpleContactsApp.swift
//  SimpleContacts
//
//  Created by Lujain Almulaifi on 10/10/2026.
//

import SwiftUI
import SwiftData

@main
struct SimpleContactsApp: App {
    var body: some Scene {
        WindowGroup {
            AppView()
        }
        .modelContainer(for: Person.self)
    }
}
