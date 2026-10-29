//
//  CarCoordinateTests.swift
//  FindMyCarTests
//
//  Created by Lujain Almulaifi on 30/10/2026.
//

import Testing
import Foundation
@testable import FindMyCar

struct CarCoordinateTests {

    // The default coordinate should be 0,0
    @Test func defaultInitializerIsZero() {
        let coord = CarCoordinate()
        #expect(coord.latitude == 0.0)
        #expect(coord.longitude == 0.0)
    }

    // A custom coordinate should keep the values we give it
    @Test func customInitializerStoresValues() {
        let coord = CarCoordinate(latitude: 40.7128, longitude: -74.0060)
        #expect(coord.latitude == 40.7128)
        #expect(coord.longitude == -74.0060)
    }

    // Equal values should compare equal, different values should not
    @Test func equalityWorks() {
        let a = CarCoordinate(latitude: 40.4446, longitude: -79.9454)
        let b = CarCoordinate(latitude: 40.4446, longitude: -79.9454)
        let c = CarCoordinate(latitude: 0, longitude: 0)
        #expect(a == b)
        #expect(a != c)
    }

    // Encoding to a plist and decoding back should give the same value
    @Test func encodesAndDecodesRoundTrip() throws {
        let original = CarCoordinate(latitude: 40.4446, longitude: -79.9454)
        let data = try PropertyListEncoder().encode(original)
        let decoded = try PropertyListDecoder().decode(CarCoordinate.self, from: data)
        #expect(decoded == original)
    }
}
