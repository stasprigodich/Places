//
//  SearchPlacesInteractor.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import Foundation

protocol SearchPlacesInteractorProtocol {
    func fetchLocations() async throws -> [Location]
}

class SearchPlacesInteractor: SearchPlacesInteractorProtocol {

    private let service: SearchPlacesNetworkServiceProtocol

    init(service: SearchPlacesNetworkServiceProtocol) {
        self.service = service
    }

    func fetchLocations() async throws -> [Location] {
        return try await service.fetchLocations()
    }
}

