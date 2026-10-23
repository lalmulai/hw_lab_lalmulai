//
//  TaskRepository.swift
//  Arbeit
//
//  Created by Lujain Almulaifi on 23/10/2026.
//

import Foundation
import Observation
import FirebaseFirestore

/// Talks to Firestore. Owns the live list of tasks and the create, update, and delete operations.
@Observable
class TaskRepository {

    /// Name of the Firestore collection that holds the tasks.
    @ObservationIgnored private let path: String = "tasks"
    /// Handle to the Firestore database.
    @ObservationIgnored private let store = Firestore.firestore()
    /// Keeps the snapshot listener so it can be removed later.
    @ObservationIgnored private var listener: ListenerRegistration?

    /// The current tasks. Views update automatically when this changes.
    var tasks: [TaskItem] = []

    /// Starts listening to Firestore as soon as the repository is created.
    init() {
        self.get()
    }

    /// Stops the Firestore listener when the repository goes away, to avoid a leak.
    deinit {
        listener?.remove()
    }

    /// Attaches a real-time listener. Whenever the database changes, tasks is refreshed.
    func get() {
        listener = store.collection(path)
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let self = self else { return }

                if let error = error {
                    print("Error getting tasks: \(error.localizedDescription)")
                    return
                }

                // Convert each Firestore document into a TaskItem, skipping any that fail to decode.
                self.tasks = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: TaskItem.self)
                } ?? []
            }
    }

    // MARK: CRUD methods

    /// Adds a new task document to Firestore (Firestore generates the ID).
    func create(_ task: TaskItem) {
        do {
            _ = try store.collection(path).addDocument(from: task)
        } catch {
            print("Error creating task: \(error.localizedDescription)")
        }
    }

    /// Overwrites an existing task document with the edited values.
    func update(_ task: TaskItem) {
        guard let taskId = task.id else {
            print("Error updating task: Task ID is missing")
            return
        }

        do {
            try store.collection(path).document(taskId).setData(from: task)
        } catch {
            print("Error updating task: \(error.localizedDescription)")
        }
    }

    /// Deletes the task's document from Firestore.
    func delete(_ task: TaskItem) {
        guard let taskId = task.id else {
            print("Error deleting task: Task ID is missing")
            return
        }

        store.collection(path).document(taskId).delete { error in
            if let error = error {
                print("Error deleting task: \(error.localizedDescription)")
            }
        }
    }
}
