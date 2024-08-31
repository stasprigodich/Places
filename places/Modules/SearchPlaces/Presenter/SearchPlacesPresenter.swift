//
//  SearchPlacesPresenter.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import SwiftUI

typealias ViewState = SearchPlacesViewState

@MainActor
protocol SearchPlacesPresenterProtocol: ObservableObject {
    var searchQuery: String { get set }
    var viewState: ViewState { get }
    var showWikipediaAppAlert: Bool { get set }
    
    func loadLocations() async
    func openWikipediaApp(with coordinate: Coordinate)
    func openWikipediaApp(with query: String)
}

@MainActor
class SearchPlacesPresenter: SearchPlacesPresenterProtocol {
    @Published var searchQuery: String = "" {
        didSet {
            if !locations.isEmpty {
                updateFilteredLocations()
            }
        }
    }
    @Published private(set) var viewState: ViewState = .loading {
        didSet {
            accessibilityAnnounceViewState(viewState)
        }
    }
    @Published var showWikipediaAppAlert: Bool = false

    private var locations: [LocationViewModel] = []
    private var filterTask: Task<Void, Never>?

    private let interactor: SearchPlacesInteractorProtocol
    private let router: SearchPlacesRouterProtocol

    init(interactor: SearchPlacesInteractorProtocol, router: SearchPlacesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    private func updateFilteredLocations() {
        if case .error = viewState { return }
        filterTask?.cancel()
        filterTask = Task {
            let query = searchQuery.lowercased()
            let filtered = await filterLocations(with: query)
            if !Task.isCancelled {
                if filtered.isEmpty {
                    viewState = .empty(Strings.SearchPlaces.emptyMessage)
                } else {
                    viewState = .results(filtered)
                }
            }
        }
    }

    private func filterLocations(with query: String) async -> [LocationViewModel] {
        let currentLocations = locations
        return await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                let filtered = currentLocations.filter { location in
                    return location.name.lowercased().hasPrefix(query)
                }
                continuation.resume(returning: filtered)
            }
        }
    }

    func loadLocations() async {
        accessibilityAnnounceScreenChange()
        viewState = .loading
        do {
            let models = try await interactor.fetchLocations()
            locations = models.map { .init(with: $0) }
            updateFilteredLocations()
        } catch {
            viewState = .error(Strings.SearchPlaces.errorMessage)
        }
    }
    
    func openWikipediaApp(with coordinate: Coordinate) {
        if !router.routeToWikipedia(with: coordinate) {
            showWikipediaAppAlert = true
        }
    }
    
    func openWikipediaApp(with query: String) {
        guard !query.isEmpty else { return }
        if !router.routeToWikipedia(with: query) {
            showWikipediaAppAlert = true
        }
    }

    func accessibilityAnnounceViewState(_ newState: ViewState) {
        UIAccessibility.post(notification: .layoutChanged, argument: nil)

        switch newState {
        case .loading:
            UIAccessibility.post(notification: .announcement, argument: Strings.SearchPlaces.accessibilityLoading)
        case .error(_):
            UIAccessibility.post(notification: .announcement, argument: Strings.SearchPlaces.accessibilityError)
        case .empty:
            UIAccessibility.post(notification: .announcement, argument: Strings.SearchPlaces.accessibilityEmpty)
        case .results(let locations):
            UIAccessibility.post(notification: .announcement, argument: String(format: Strings.SearchPlaces.accessibilityResult, locations.count))
        }
    }

    func accessibilityAnnounceScreenChange() {
        UIAccessibility.post(notification: .screenChanged, argument: nil)
    }
}

