//
//  TaskItemTests.swift
//  ArbeitTests
//
//  Created by Lujain Almulaifi on 23/10/2026.
//

import Testing
import Foundation
@testable import Arbeit

/// Unit tests for TaskItem's validation, equality, and sorting. No Firebase needed.
@MainActor
struct TaskItemTests {

    /// A fixed date so two samples are truly equal (Date() would differ slightly each call).
    private static let fixedDate = Date(timeIntervalSince1970: 1_700_000_000)

    /// Builds a TaskItem with sensible defaults so each test only sets what it cares about.
    private func sample(name: String = "Write lab",
                        assignedTo: String = "Prof H",
                        dueDate: Date = TaskItemTests.fixedDate) -> TaskItem {
        TaskItem(
            name: name,
            assignedTo: assignedTo,
            dueDate: dueDate,
            dateAdded: TaskItemTests.fixedDate,
            completed: false
        )
    }

    /// An empty name should fail validation.
    @Test func validationRejectsEmptyName() {
        #expect(TaskItem.isValid(name: "", assignedTo: "someone") == false)
    }

    /// An empty assignee should fail validation.
    @Test func validationRejectsEmptyAssignee() {
        #expect(TaskItem.isValid(name: "something", assignedTo: "") == false)
    }

    /// A task with both a name and an assignee should pass validation.
    @Test func validationAcceptsBothPresent() {
        #expect(TaskItem.isValid(name: "something", assignedTo: "someone") == true)
    }

    /// == should ignore id and completed and compare only name, assignee, and due date.
    @Test func equalityIgnoresIdAndCompletion() {
        var a = sample()
        var b = sample()
        a.id = "abc"
        b.id = "xyz"
        b.completed = true

        #expect(a == b)
    }

    /// Sorting a list of tasks should order them alphabetically by name.
    @Test func sortsByName() {
        let apple = sample(name: "Apple")
        let banana = sample(name: "Banana")
        let cherry = sample(name: "Cherry")

        let sorted = [cherry, apple, banana].sorted()

        #expect(sorted.map(\.name) == ["Apple", "Banana", "Cherry"])
    }
}
