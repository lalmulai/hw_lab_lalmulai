//
//  CarLocation.swift
//  FindMyCar
//
//  Created by Lujain Almulaifi on 30/10/2026.
//

import Foundation
import CoreLocation

// Helper struct to make the car location identifiable for Map annotations
struct CarLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
    let subtitle: String
}
