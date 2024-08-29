//
//  SearchPlacesDI.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

protocol SearchPlacesDI {
    
    var searchPlacesInteractorProtocol: SearchPlacesInteractorProtocol { get }
    var searchPlacesRouterProtocol: SearchPlacesRouterProtocol { get }
    var searchPlacesNetworkServiceProtocol: SearchPlacesNetworkServiceProtocol { get }
}

extension DI: SearchPlacesDI {
    
    static var searchPlaces: SearchPlacesDI {
        shared()
    }
    
    var searchPlacesInteractorProtocol: SearchPlacesInteractorProtocol {
        stored(by: #function) {
            SearchPlacesInteractor(service: searchPlacesNetworkServiceProtocol)
        }
    }

    var searchPlacesRouterProtocol: SearchPlacesRouterProtocol {
        stored(by: #function) {
            SearchPlacesRouter()
        }
    }
    
    var searchPlacesNetworkServiceProtocol: SearchPlacesNetworkServiceProtocol {
        stored(by: #function) {
            SearchPlacesNetworkService(networkService: DI.network.networkServiceProtocol)
        }
    }
}
