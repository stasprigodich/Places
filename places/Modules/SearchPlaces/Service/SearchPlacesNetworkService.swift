//
//  SearchPlacesNetworkService.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import Foundation

// MARK: - Protocol

protocol SearchPlacesNetworkServiceProtocol {
    func fetchLocations() async throws -> [Location]
}

// MARK: - Implementation

class SearchPlacesNetworkService: SearchPlacesNetworkServiceProtocol {
    
    // MARK: - Private Properties
    
    private let networkService: NetworkServiceProtocol

    // MARK: - Initializer
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    // MARK: - Internal Methods
    
    func fetchLocations() async throws -> [Location] {
        guard let url = APIConstants.locationsURL else {
            throw NetworkError.invalidURL
        }
        let request = NetworkRequest(url: url)
        do {
            let data = try await networkService.performRequest(request)
            let response = try JSONDecoder().decode(LocationsResponseDTO.self, from: data)
            return response.convertToEntity()
        } catch {
            print("Failed to fetch locations with error: \(error.localizedDescription)")
            throw NetworkError.decodingError
        }
    }
}
