//
//  MockSearchPlacesInteractor.swift
//  placesTests
//
//  Created by Stan Prigodich on 31/08/2024.
//

@testable import places
import Foundation

class MockSearchPlacesInteractor: SearchPlacesInteractorProtocol {
    var fetchLocationsCalled = false
    var shouldThrowError = false

    func fetchLocations() async throws -> [Location] {
        fetchLocationsCalled = true
        
        if shouldThrowError {
            throw NetworkError.invalidResponse
        }

        return [Location(name: "Amsterdam", coordinate: Coordinate(latitude: 0, longitude: 0))]
    }
}
