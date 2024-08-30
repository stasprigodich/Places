//
//  SearchPlacesPresenter.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import SwiftUI

@MainActor
protocol SearchPlacesPresenterProtocol: ObservableObject {
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
class SearchPlacesPresenter: SearchPlacesPresenterProtocol {
    @Published var searchQuery: String = "" {
        didSet {
            updateFilteredLocations()
        }
    }
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var errorMessage: String? = nil
    @Published var showWikipediaAppAlert: Bool = false
    @Published private(set) var filteredLocations: [LocationViewModel] = []

    private var locations: [LocationViewModel] = []
    private var filterTask: Task<Void, Never>?

    private let interactor: SearchPlacesInteractorProtocol
    private let router: SearchPlacesRouterProtocol

    init(interactor: SearchPlacesInteractorProtocol, router: SearchPlacesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    private func updateFilteredLocations() {
        filterTask?.cancel()
        filterTask = Task {
            let query = searchQuery.lowercased()
            let filtered = await filterLocations(with: query)
            if !Task.isCancelled {
                filteredLocations = filtered
            }
        }
    }

    private func filterLocations(with query: String) async -> [LocationViewModel] {
        let currentLocations = locations
        return await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                let filtered = currentLocations.filter { location in
                    if let name = location.name {
                        return name.lowercased().hasPrefix(query)
                    }
                    return false
                }
                continuation.resume(returning: filtered)
            }
        }
    }

    func loadLocations() async {
        isLoading = true
        errorMessage = nil
        do {
            let models = try await interactor.fetchLocations()
            locations = models.map { .init(with: $0) }
            updateFilteredLocations()
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

