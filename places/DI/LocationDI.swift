//
//  LocationDI.swift
//  places
//
//  Created by Stan Prigodich on 01/09/2024.
//

protocol LocationDI {
    
    var locationServiceProtocol: LocationServiceProtocol { get }
}

extension DI: LocationDI {
    
    static var location: LocationDI {
        shared()
    }

    var locationServiceProtocol: LocationServiceProtocol {
        stored(by: #function) {
            LocationService()
        }
    }
}
