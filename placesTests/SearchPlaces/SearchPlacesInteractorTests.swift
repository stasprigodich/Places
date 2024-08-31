//
//  SearchPlacesInteractorTests.swift
//  placesTests
//
//  Created by Stan Prigodich on 31/08/2024.
//

import XCTest
@testable import places

final class SearchPlacesInteractorTests: XCTestCase {
    var interactor: SearchPlacesInteractor!
    var mockService: MockSearchPlacesNetworkService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = MockSearchPlacesNetworkService()
        interactor = SearchPlacesInteractor(service: mockService)
    }

    override func tearDownWithError() throws {
        interactor = nil
        mockService = nil
        try super.tearDownWithError()
    }

    func testFetchLocationsSuccess() async throws {
        let expectedLocations = [Location(name: "Amsterdam", coordinate: Coordinate(latitude: 0, longitude: 0))]
        mockService.mockLocations = expectedLocations

        let locations = try await interactor.fetchLocations()

        XCTAssertEqual(locations.count, expectedLocations.count)
        XCTAssertEqual(locations.first?.name, expectedLocations.first?.name)
    }

    func testFetchLocationsFailure() async {
        mockService.shouldThrowError = true
        do {
            _ = try await interactor.fetchLocations()
            XCTFail("Expected fetchLocations to throw, but it did not")
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.invalidResponse)
        }
    }
}
