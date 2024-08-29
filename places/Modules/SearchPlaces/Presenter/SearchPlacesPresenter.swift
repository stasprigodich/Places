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
    
    func loadLocations() async
    func openWikipediaApp(with coordinate: Coordinate)
    func openWikipediaApp(with query: String)
}

@MainActor
class SearchPlacesPresenter: ObservableObject, SearchPlacesPresenterProtocol {
    @Published var searchQuery: String = ""
    @Published private(set) var filteredLocations: [LocationViewModel] = []
    
    private let mockLocations: [Location] = [
        .init(name: "Amsterdam", coordinate: .init(latitude: 21.0, longitude: 23.0))
    ]
    
    func loadLocations() async {
        filteredLocations = mockLocations.map { .init(with: $0) }
    }
    
    func openWikipediaApp(with coordinate: Coordinate) {

    }
    
    func openWikipediaApp(with query: String) {
        guard !query.isEmpty else { return }
    }
}

