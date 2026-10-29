//
//  LocationManager.swift
//  FindMyCar
//
//  Created by Lujain Almulaifi on 30/10/2026.
//

import Foundation
import CoreLocation
import Observation

@Observable
class LocationManager: NSObject {

    // MARK: - Observable Properties
    var coordinate = CarCoordinate()
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var locationError: String?

    // MARK: - Private Properties
    @ObservationIgnored private let locationManager = CLLocationManager()
    @ObservationIgnored private let plistFileName = "Coordinates.plist"
    @ObservationIgnored private var locationSaveCompletion: (() -> Void)?

    // MARK: - Initialization
    // Sets up the CLLocationManager, reads the current permission, and loads any saved car location
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        authorizationStatus = locationManager.authorizationStatus
        loadLocation()
    }

    // MARK: - Public Methods
    // Requests location permissions and gets current location
    func saveCurrentLocation(completion: @escaping () -> Void = {}) {
        // Clear any previous errors
        locationError = nil

        // Store completion handler to call after location is saved
        locationSaveCompletion = completion

        // Check authorization status
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            locationError = "Location access denied. Please enable in Settings."
            locationSaveCompletion?()
            locationSaveCompletion = nil
            return
        case .authorizedWhenInUse, .authorizedAlways:
            startLocationUpdates()
        @unknown default:
            locationError = "Unknown authorization status"
            locationSaveCompletion?()
            locationSaveCompletion = nil
        }
    }

    // Clears the saved car location
    func clearLocation() {
        coordinate = CarCoordinate()
        saveLocationToPlist()
    }

    // MARK: - Persistence Methods
    // This is such a small amount of data that we are just going to use
    // a plist-based persistence using Codable

    // Saves the current coordinate to a plist file using PropertyListEncoder
    private func saveLocationToPlist() {
        do {
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml
            let data = try encoder.encode(coordinate)
            try data.write(to: plistURL(), options: .atomic)
        } catch {
            print("Error saving location: \(error.localizedDescription)")
            locationError = "Failed to save location"
        }
    }

    // Loads the coordinate from the plist file using PropertyListDecoder
    private func loadLocation() {
        let url = plistURL()

        guard FileManager.default.fileExists(atPath: url.path) else {
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            coordinate = try decoder.decode(CarCoordinate.self, from: data)
        } catch {
            print("Error loading location: \(error.localizedDescription)")
        }
    }

    // MARK: - Private Helper Methods

    // Starts a location update if location services are enabled
    private func startLocationUpdates() {
        guard CLLocationManager.locationServicesEnabled() else {
            locationError = "Location services are disabled"
            return
        }
        locationManager.startUpdatingLocation()
    }

    // Returns the URL for the plist file in the documents directory
    private func plistURL() -> URL {
        URL.documentsDirectory.appendingPathComponent(plistFileName)
    }
}

// MARK: - CLLocationManagerDelegate
// Teaching note: Use of delegate pattern for location services (discussed in class)

extension LocationManager: CLLocationManagerDelegate {

    // Called when the user changes the permission; starts updates if now authorized
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus

        // If authorized, start getting location
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            startLocationUpdates()
        }
    }

    // Called when a new location arrives; saves it, stops updates, and notifies the UI
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        // Update coordinate
        coordinate = CarCoordinate(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )

        // Save to plist
        saveLocationToPlist()

        // Stop updating to conserve battery
        locationManager.stopUpdatingLocation()

        // Call completion handler after location is saved
        locationSaveCompletion?()
        locationSaveCompletion = nil
    }

    // Called when getting a location fails; records the error and notifies the UI
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationError = "Failed to get location: \(error.localizedDescription)"
        locationManager.stopUpdatingLocation()

        // Call completion handler even on error so UI can respond
        locationSaveCompletion?()
        locationSaveCompletion = nil
    }
}
