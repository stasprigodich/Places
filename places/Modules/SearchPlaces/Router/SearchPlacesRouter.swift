//
//  SearchPlacesRouter.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import Foundation
import UIKit

protocol SearchPlacesRouterProtocol {
    func routeToWikipedia(with coordinate: Coordinate) -> Bool
}

class SearchPlacesRouter: SearchPlacesRouterProtocol {
    
    func routeToWikipedia(with coordinate: Coordinate) -> Bool {
        let urlString = "wikipedia://places?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            return true
        } else {
            print("Cannot open Wikipedia app.")
            return false
        }
    }
}

