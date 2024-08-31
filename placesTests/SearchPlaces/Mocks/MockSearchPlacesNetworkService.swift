//
//  MockSearchPlacesNetworkService.swift
//  placesTests
//
//  Created by Stan Prigodich on 31/08/2024.
//

@testable import places
import Foundation

class MockSearchPlacesNetworkService: SearchPlacesNetworkServiceProtocol {
    var shouldThrowError = false
    var mockLocations: [Location] = []

    func fetchLocations() async throws -> [Location] {
        if shouldThrowError {
            throw NetworkError.invalidResponse
        }
        return mockLocations
    }
}
