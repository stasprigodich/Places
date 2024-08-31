//
//  SearchPlacesPresenterTests.swift
//  placesTests
//
//  Created by Stan Prigodich on 31/08/2024.
//

import XCTest
@testable import places

final class SearchPlacesPresenterTests: XCTestCase {
    var presenter: SearchPlacesPresenter!
    var mockInteractor: MockSearchPlacesInteractor!
    var mockRouter: MockSearchPlacesRouter!

    @MainActor
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockSearchPlacesInteractor()
        mockRouter = MockSearchPlacesRouter()
        presenter = SearchPlacesPresenter(interactor: mockInteractor, router: mockRouter)
    }

    override func tearDownWithError() throws {
        presenter = nil
        mockInteractor = nil
        mockRouter = nil
        try super.tearDownWithError()
    }

    @MainActor
    func testLoadLocationsCallsInteractor() async throws {
        await presenter.loadLocations()
        XCTAssertTrue(mockInteractor.fetchLocationsCalled)
    }

    @MainActor
    func testLoadLocationsSetsViewStateToResults() async throws {
        await presenter.loadLocations()
        if case .results(let locationViewModels) = presenter.viewState {
            let locationNames = locationViewModels.map { $0.name }
            XCTAssertEqual(locationNames, ["Amsterdam"])
        } else {
            XCTFail("Expected viewState to be .results, but it was \(presenter.viewState)")
        }
    }

    @MainActor
    func testLoadLocationsSetsViewStateToError() async throws {
        mockInteractor.shouldThrowError = true
        await presenter.loadLocations()
        XCTAssertEqual(presenter.viewState, .error("Failed to load places"))
    }

    @MainActor
    func testOpenWikipediaAppWithCoordinateCallsRouter() async throws {
        presenter.openWikipediaApp(with: Coordinate(latitude: 0, longitude: 0))
        XCTAssertTrue(mockRouter.routeToWikipediaCalled)
    }

    @MainActor
    func testOpenWikipediaAppWithQueryCallsRouter() async throws {
        presenter.openWikipediaApp(with: "Test Query")
        XCTAssertTrue(mockRouter.routeToWikipediaCalled)
    }
}
