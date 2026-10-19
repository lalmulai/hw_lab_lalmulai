//
//  Person.swift
//  SimpleContacts
//
//  Created by Lujain Almulaifi on 10/10/2026.
//

import SwiftData
import Foundation

@Model
class Person {
    var name: String
    var email: String
    var details: String
    @Attribute(.externalStorage) var photo: Data?

    init(name: String, email: String, details: String, photo: Data? = nil) {
        self.name = name
        self.email = email
        self.details = details
        self.photo = photo
    }
}
