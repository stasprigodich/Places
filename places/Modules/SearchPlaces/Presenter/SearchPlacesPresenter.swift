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
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var showWikipediaAppAlert: Bool { get set }
    
    func loadLocations() async
    func openWikipediaApp(with coordinate: Coordinate)
    func openWikipediaApp(with query: String)
}

@MainActor
class SearchPlacesPresenter: ObservableObject, SearchPlacesPresenterProtocol {
    @Published private(set) var locations: [Location] = []
    @Published var searchQuery: String = ""
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var errorMessage: String? = nil
    @Published var showWikipediaAppAlert: Bool = false

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
                    return name.lowercased().hasPrefix(searchQuery.lowercased())
                }
                return false
            }
            .map { .init(with: $0) }
        }
    }
    
    func loadLocations() async {
        isLoading = true
        errorMessage = nil
        do {
            locations = try await interactor.fetchLocations()
        } catch {
            errorMessage = "Failed to load locations"
        }
        isLoading = false
    }
    
    func openWikipediaApp(with coordinate: Coordinate) {
        if !router.routeToWikipedia(with: coordinate) {
            showWikipediaAppAlert = true
        }
    }
    
    func openWikipediaApp(with query: String) {
        guard !query.isEmpty else { return }
    }
}

