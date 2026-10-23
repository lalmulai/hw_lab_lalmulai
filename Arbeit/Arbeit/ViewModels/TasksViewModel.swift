//
//  TasksViewModel.swift
//  Arbeit
//
//  Created by Lujain Almulaifi on 23/10/2026.
//

import Foundation
import Observation

/// Sits between the views and the repository so views never talk to Firestore directly.
@Observable
class TasksViewModel {

    /// The data layer. Injected so tests can pass in a replacement.
    @ObservationIgnored private let repository: TaskRepository

    /// Creates the view model, using a fresh repository unless one is provided.
    init(repository: TaskRepository = TaskRepository()) {
        self.repository = repository
    }

    /// The live list of tasks, read straight from the repository.
    var tasks: [TaskItem] {
        repository.tasks
    }

    /// Saves a new task.
    func add(_ task: TaskItem) {
        repository.create(task)
    }

    /// Saves changes to an existing task.
    func update(_ task: TaskItem) {
        repository.update(task)
    }

    /// Deletes a task.
    func destroy(_ task: TaskItem) {
        repository.delete(task)
    }
}
