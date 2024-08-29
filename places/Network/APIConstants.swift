//
//  APIConstants.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import Foundation

struct APIConstants {
    
    static let baseURL = "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main"
    static let locationsEndpoint = "/locations.json"
    
    static var locationsURL: URL? {
        return URL(string: baseURL + locationsEndpoint)
    }
}
