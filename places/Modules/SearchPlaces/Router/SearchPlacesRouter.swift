//
//  SearchPlacesRouter.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol SearchPlacesRouterProtocol {
    func routeToWikipedia(with coordinate: Coordinate) -> Bool
    func routeToWikipedia(with query: String) -> Bool
}

// MARK: - Implementation

final class SearchPlacesRouter: SearchPlacesRouterProtocol {
    
    // MARK: - Internal Methods
    
    func routeToWikipedia(with coordinate: Coordinate) -> Bool {
        let urlString = "wikipedia://places?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            return true
        } else {
            return false
        }
    }

    func routeToWikipedia(with query: String) -> Bool {
        let query = query.replacingOccurrences(of: " ", with: "_")
        let urlString = "wikipedia://places?WMFArticleURL=https://en.wikipedia.org/wiki/\(query)"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            return true
        } else {
            return false
        }
    }
}

