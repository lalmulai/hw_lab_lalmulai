//
//  LocationManagerTests.swift
//  FindMyCarTests
//
//  Created by Lujain Almulaifi on 30/10/2026.
//

import Testing
import CoreLocation
@testable import FindMyCar

@MainActor
struct LocationManagerTests {

    // A new manager should start with the 0,0 coordinate
    @Test func startsWithZeroCoordinate() {
        let manager = LocationManager()
        #expect(manager.coordinate == CarCoordinate())
    }

    // clearLocation should reset the saved coordinate to 0,0
    @Test func clearLocationResetsCoordinate() {
        let manager = LocationManager()
        manager.coordinate = CarCoordinate(latitude: 40.4446, longitude: -79.9454)
        manager.clearLocation()
        #expect(manager.coordinate == CarCoordinate())
    }

    // Saving with denied permission should set an error message
    @Test func deniedAuthorizationProducesError() {
        let manager = LocationManager()
        manager.authorizationStatus = .denied
        manager.saveCurrentLocation()
        #expect(manager.locationError != nil)
    }
}
