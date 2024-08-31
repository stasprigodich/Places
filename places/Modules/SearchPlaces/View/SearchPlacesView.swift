//
//  SearchPlacesView.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import SwiftUI

// MARK: - SearchPlacesView

struct SearchPlacesView<T: SearchPlacesPresenterProtocol>: View {
    @ObservedObject var presenter: T

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                searchField
                mainContent
            }
            .navigationTitle(Strings.SearchPlaces.title)
            .background(Color(.secondarySystemGroupedBackground))
            .alert(isPresented: $presenter.showWikipediaAppAlert) {
                WikipediaAppAlert.build()
            }
            .onAppear {
                Task {
                    await presenter.loadLocations()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Subviews
    
    private var searchField: some View {
        SearchTextField(text: $presenter.searchQuery) { query in
            presenter.openWikipediaApp(with: query)
        }
        .padding()
    }
    
    private var mainContent: some View {
        ZStack {
            Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            
            switch presenter.viewState {
            case .loading:
                SearchPlacesLoadingView()
            case .error(let message):
                SearchPlacesErrorView(message: message) {
                    Task {
                        await presenter.loadLocations()
                    }
                }
            case .empty(let message):
                SearchPlacesEmptyView(message: message)
            case .results(let locations):
                SearchPlacesResultView(locations: locations) { coordinate in
                    presenter.openWikipediaApp(with: coordinate)
                }
            }
        }
    }
}

// MARK: - Preview

struct SearchPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = MockPreviewPresenter()
        return SearchPlacesView(presenter: presenter)
    }
}

private class MockPreviewPresenter: SearchPlacesPresenterProtocol {
    var searchQuery: String = ""
    var viewState: ViewState = .results([
        .init(
            name: "Amsterdam",
            coordinate: .init(latitude: 0, longitude: 0)
        )
    ])
    
    var showWikipediaAppAlert: Bool = false
    func loadLocations() async { }
    func openWikipediaApp(with coordinate: Coordinate) { }
    func openWikipediaApp(with query: String) { }
}
