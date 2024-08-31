//
//  MockNetworkService.swift
//  placesTests
//
//  Created by Stan Prigodich on 31/08/2024.
//

@testable import places
import Foundation

class MockNetworkService: NetworkServiceProtocol {
    var shouldThrowError = false
    var mockData: Data?

    func performRequest(_ request: NetworkRequest) async throws -> Data {
        if shouldThrowError {
            throw NetworkError.decodingError
        }
        if let data = mockData {
            return data
        } else {
            throw NetworkError.invalidResponse
        }
    }
}
