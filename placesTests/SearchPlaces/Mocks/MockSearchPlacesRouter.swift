//
//  MockSearchPlacesRouter.swift
//  placesTests
//
//  Created by Stan Prigodich on 31/08/2024.
//

@testable import places
import Foundation

final class MockSearchPlacesRouter: SearchPlacesRouterProtocol {
    var routeToWikipediaCalled = false
    
    func routeToWikipedia(with coordinate: Coordinate) -> Bool {
        routeToWikipediaCalled = true
        return true
    }
    
    func routeToWikipedia(with query: String) -> Bool {
        routeToWikipediaCalled = true
        return true
    }
}
