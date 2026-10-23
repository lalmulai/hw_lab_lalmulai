//
//  TaskRowView.swift
//  Arbeit
//
//  Created by Lujain Almulaifi on 23/10/2026.
//

import SwiftUI

/// One row in the task list: name, assignee, due date, and a checkmark when completed.
struct TaskRowView: View {
    let task: TaskItem

    /// Lays out the row's text and the completed checkmark.
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(task.name)
                    .font(.headline)
                    .strikethrough(task.completed)

                Text("Assigned to: \(task.assignedTo)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("Due: \(task.dueDate, style: .date)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            if task.completed {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
        .padding(.vertical, 4)
    }
}
