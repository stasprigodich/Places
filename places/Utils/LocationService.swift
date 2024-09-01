//
//  LocationService.swift
//  places
//
//  Created by Stan Prigodich on 01/09/2024.
//

import Foundation
import CoreLocation

// MARK: - Protocol

protocol LocationServiceProtocol {
    func getLocationName(latitude: Double, longitude: Double) async -> String?
}

// MARK: - Implementation

final class LocationService: LocationServiceProtocol {
    
    // MARK: - Private Properties

    private let geocoder = CLGeocoder()
    
    // MARK: - Internal Methods

    func getLocationName(latitude: Double, longitude: Double) async -> String? {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        return await withCheckedContinuation { continuation in
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if error != nil {
                    continuation.resume(returning: nil)
                    return
                }
                guard let placemark = placemarks?.first else {
                    continuation.resume(returning: nil)
                    return
                }
                
                let locationName = placemark.locality ?? placemark.country ?? placemark.name
                continuation.resume(returning: locationName)
            }
        }
    }
}

