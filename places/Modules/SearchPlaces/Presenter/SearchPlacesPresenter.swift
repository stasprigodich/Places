//
//  SearchPlacesPresenter.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import SwiftUI

// MARK: - Typealias

typealias ViewState = SearchPlacesViewState

// MARK: - Protocol

@MainActor
protocol SearchPlacesPresenterProtocol: ObservableObject {
    var searchQuery: String { get set }
    var viewState: ViewState { get }
    var showWikipediaAppAlert: Bool { get set }
    
    func loadLocations() async
    func openWikipediaApp(with coordinate: Coordinate)
    func openWikipediaApp(with query: String)
}

// MARK: - Implementation

@MainActor
final class SearchPlacesPresenter: SearchPlacesPresenterProtocol {
    
    // MARK: - Published Properties
    
    @Published var searchQuery: String = "" {
        didSet {
            if !locations.isEmpty {
                Task {
                    await updateFilteredLocations()
                }
            }
        }
    }
    @Published private(set) var viewState: ViewState = .loading {
        didSet {
            accessibilityAnnounceViewState(viewState)
        }
    }
    @Published var showWikipediaAppAlert: Bool = false

    // MARK: - Private Properties
    
    private var locations: [LocationViewModel] = []
    private var filterTask: Task<Void, Never>?
    private let interactor: SearchPlacesInteractorProtocol
    private let router: SearchPlacesRouterProtocol

    // MARK: - Initializer
    
    init(interactor: SearchPlacesInteractorProtocol, router: SearchPlacesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Internal Methods
    
    func loadLocations() async {
        accessibilityAnnounceScreenChange()
        viewState = .loading
        do {
            let models = try await interactor.fetchLocations()
            locations = await mapModelsToViewModels(from: models)
            await updateFilteredLocations()
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
    
    // MARK: - Private Methods
    
    private func mapModelsToViewModels(from models: [Location]) async -> [LocationViewModel] {
        await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                Task {
                    var indexedViewModels = [(Int, LocationViewModel)]()
                    
                    await withTaskGroup(of: (Int, LocationViewModel).self) { taskGroup in
                        for (index, model) in models.enumerated() {
                            taskGroup.addTask {
                                let viewModel = await LocationViewModel(with: model)
                                return (index, viewModel)
                            }
                        }
                        for await result in taskGroup {
                            indexedViewModels.append(result)
                        }
                    }
                    
                    indexedViewModels.sort(by: { $0.0 < $1.0 })
                    let viewModels = indexedViewModels.map { $0.1 }
                    continuation.resume(returning: viewModels)
                }
            }
        }
    }
    
    private func updateFilteredLocations() async {
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
        await filterTask?.value
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

    private func accessibilityAnnounceViewState(_ newState: ViewState) {
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

    private func accessibilityAnnounceScreenChange() {
        UIAccessibility.post(notification: .screenChanged, argument: nil)
    }
}

