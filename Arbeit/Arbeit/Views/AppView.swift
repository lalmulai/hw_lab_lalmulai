//
//  AppView.swift
//  Arbeit
//
//  Created by Lujain Almulaifi on 23/10/2026.
//

import SwiftUI

/// Root view: owns the view model and shows the two tabs.
struct AppView: View {
    @State private var tasksViewModel = TasksViewModel()

    /// Builds the tab bar and shares the view model with every screen through the environment.
    var body: some View {
        TabView {
            NavigationStack {
                TasksView()
            }
            .tabItem {
                Image(systemName: "checkmark.rectangle.stack.fill")
                Text("Tasks")
            }

            NavigationStack {
                NewTaskView()
            }
            .tabItem {
                Image(systemName: "plus.app.fill")
                Text("New Task")
            }
        }
        .environment(tasksViewModel)
    }
}
