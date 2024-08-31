//
//  SearchPlacesNetworkServiceTests.swift
//  placesTests
//
//  Created by Stan Prigodich on 31/08/2024.
//

import XCTest
@testable import places

final class SearchPlacesNetworkServiceTests: XCTestCase {
    var service: SearchPlacesNetworkService!
    var mockNetworkService: MockNetworkService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetworkService = MockNetworkService()
        service = SearchPlacesNetworkService(networkService: mockNetworkService)
    }

    override func tearDownWithError() throws {
        service = nil
        mockNetworkService = nil
        try super.tearDownWithError()
    }

    func testFetchLocationsSuccess() async throws {
        let mockResponse = LocationsResponseDTO(locations: [
            LocationDTO(name: "Amsterdam", lat: 0, long: 0)
        ])
        mockNetworkService.mockData = try JSONEncoder().encode(mockResponse)

        let locations = try await service.fetchLocations()

        XCTAssertEqual(locations.count, 1)
        XCTAssertEqual(locations.first?.name, "Amsterdam")
    }

    func testFetchLocationsDecodingError() async {
        mockNetworkService.mockData = Data()
        do {
            _ = try await service.fetchLocations()
            XCTFail("Expected fetchLocations to throw, but it did not")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .decodingError)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
}
