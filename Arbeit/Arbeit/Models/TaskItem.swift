//
//  TaskItem.swift
//  Arbeit
//
//  Created by Lujain Almulaifi on 23/10/2026.
//

import Foundation
import FirebaseFirestore

/// One task, stored as a document in the Firestore "tasks" collection.
struct TaskItem: Identifiable, Comparable, Codable, Hashable {

    // MARK: Fields

    /// Firestore document ID. Optional because new tasks have no ID until saved.
    @DocumentID var id: String?
    var name: String
    var assignedTo: String
    var dueDate: Date
    var dateAdded: Date
    var completed: Bool

    // MARK: Codable

    /// Maps each property to its field name in Firestore.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case assignedTo
        case dueDate
        case dateAdded
        case completed
    }

    // MARK: Comparable

    /// Two tasks are equal when name, assignee, and due date match (id and completion are ignored).
    static func ==(lhs: TaskItem, rhs: TaskItem) -> Bool {
        return lhs.name == rhs.name && lhs.assignedTo == rhs.assignedTo && lhs.dueDate == rhs.dueDate
    }

    /// Orders tasks alphabetically by name, which lets arrays of tasks be sorted.
    static func <(lhs: TaskItem, rhs: TaskItem) -> Bool {
        return lhs.name < rhs.name
    }
}

// MARK: - Validation

extension TaskItem {
    /// Returns true only if both the name and the assignee are non-empty.
    static func isValid(name: String, assignedTo: String) -> Bool {
        return !name.isEmpty && !assignedTo.isEmpty
    }
}
