//
//  SearchPlacesInteractor.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import Foundation

// MARK: - Protocol

protocol SearchPlacesInteractorProtocol {
    func fetchLocations() async throws -> [Location]
}

// MARK: - Implementation

class SearchPlacesInteractor: SearchPlacesInteractorProtocol {

    // MARK: - Private Properties
    
    private let service: SearchPlacesNetworkServiceProtocol

    // MARK: - Initializer
    
    init(service: SearchPlacesNetworkServiceProtocol) {
        self.service = service
    }

    // MARK: - Internal Methods
    
    func fetchLocations() async throws -> [Location] {
        return try await service.fetchLocations()
    }
}

