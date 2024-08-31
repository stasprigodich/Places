//
//  SearchPlacesRouterTests.swift
//  placesTests
//
//  Created by Stan Prigodich on 31/08/2024.
//

import XCTest
@testable import places
import UIKit

final class SearchPlacesRouterTests: XCTestCase {
    var router: SearchPlacesRouter!

    override func setUpWithError() throws {
        try super.setUpWithError()
        router = SearchPlacesRouter()
    }

    override func tearDownWithError() throws {
        router = nil
        try super.tearDownWithError()
    }

    func testRouteToWikipediaWithCoordinateSuccess() {
        let result = router.routeToWikipedia(with: Coordinate(latitude: 0, longitude: 0))
        let urlString = "wikipedia://"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            XCTAssertTrue(result)
        } else {
            XCTAssertFalse(result)
        }
    }
    

    func testRouteToWikipediaWithQuerySuccess() {
        let result = router.routeToWikipedia(with: "")
        let urlString = "wikipedia://"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            XCTAssertTrue(result)
        } else {
            XCTAssertFalse(result)
        }
    }
}

