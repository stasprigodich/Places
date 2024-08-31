//
//  SearchPlacesView.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import SwiftUI

struct SearchPlacesView<T: SearchPlacesPresenterProtocol>: View {
    @ObservedObject var presenter: T

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                searchField
                mainContent
            }
            .navigationTitle("Places")
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
    }
    
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
            case .empty:
                SearchPlacesEmptyView()
            case .results(let locations):
                SearchPlacesResultView(locations: locations) { coordinate in
                    presenter.openWikipediaApp(with: coordinate)
                }
            }
        }
    }
}

struct SearchPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = SearchPlacesPresenter(
            interactor: DI.searchPlaces.searchPlacesInteractorProtocol,
            router: DI.searchPlaces.searchPlacesRouterProtocol
        )
        return SearchPlacesView(presenter: presenter)
    }
}
