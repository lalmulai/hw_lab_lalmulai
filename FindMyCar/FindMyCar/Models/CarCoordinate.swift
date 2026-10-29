//
//  CarCoordinate.swift
//  FindMyCar
//
//  Created by Lujain Almulaifi on 30/10/2026.
//

import Foundation

// Codable struct for plist persistence
struct CarCoordinate: Codable, Equatable {
    var latitude: Double
    var longitude: Double

    // Creates a coordinate; defaults to 0,0 which means "no location saved"
    init(latitude: Double = 0.0, longitude: Double = 0.0) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
