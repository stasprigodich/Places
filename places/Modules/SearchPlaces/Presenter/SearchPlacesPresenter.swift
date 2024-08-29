//
//  SearchPlacesPresenter.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import SwiftUI

@MainActor
protocol SearchPlacesPresenterProtocol: ObservableObject {
    var locations: [Location] { get }
    var searchQuery: String { get set }
    var filteredLocations: [LocationViewModel] { get }
    
    func loadLocations() async
    func openWikipediaApp(with coordinate: Coordinate)
    func openWikipediaApp(with query: String)
}

@MainActor
class SearchPlacesPresenter: ObservableObject, SearchPlacesPresenterProtocol {
    @Published private(set) var locations: [Location] = []
    @Published var searchQuery: String = ""
    
    private let interactor: SearchPlacesInteractorProtocol
    private let router: SearchPlacesRouterProtocol

    init(interactor: SearchPlacesInteractorProtocol, router: SearchPlacesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

    var filteredLocations: [LocationViewModel] {
        if searchQuery.isEmpty {
            return locations.map { .init(with: $0) }
        } else {
            return locations.filter { location in
                if let name = location.name {
                    return name.localizedCaseInsensitiveContains(searchQuery)
                }
                return false
            }
            .map { .init(with: $0) }
        }
    }
    
    func loadLocations() async {
        do {
            locations = try await interactor.fetchLocations()
        } catch {
            print("Failed to load locations: \(error)")
        }
    }
    
    func openWikipediaApp(with coordinate: Coordinate) {
        router.routeToWikipedia(with: coordinate)
    }
    
    func openWikipediaApp(with query: String) {
        guard !query.isEmpty else { return }
    }
}

