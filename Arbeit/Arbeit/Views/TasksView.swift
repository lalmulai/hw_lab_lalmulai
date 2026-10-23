//
//  TasksView.swift
//  Arbeit
//
//  Created by Lujain Almulaifi on 23/10/2026.
//

import SwiftUI

/// Main screen: the list of all tasks, with add (+), tap to open details, and swipe to delete.
struct TasksView: View {
    @Environment(TasksViewModel.self) private var viewModel
    @State private var showingNewTask = false

    /// Builds the list, the toolbar button, the new task sheet, and the navigation to details.
    var body: some View {
        List {
            ForEach(viewModel.tasks) { task in
                NavigationLink(value: task) {
                    TaskRowView(task: task)
                }
            }
            .onDelete(perform: deleteTask)
        }
        .navigationTitle("Arbeit")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { showingNewTask = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingNewTask) {
            NewTaskView()
                .environment(viewModel)
        }
        .navigationDestination(for: TaskItem.self) { task in
            TaskDetailsView(task: task)
        }
    }

    /// Deletes the tasks at the swiped positions.
    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            viewModel.destroy(viewModel.tasks[index])
        }
    }
}
