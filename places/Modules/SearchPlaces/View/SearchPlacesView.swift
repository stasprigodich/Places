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
            VStack {
                SearchTextField(text: $presenter.searchQuery) {
                    presenter.openWikipediaApp(with: presenter.searchQuery)
                }
                .padding()

                List(presenter.filteredLocations) { location in
                    SearchPlaceRowView(location: location) {
                        presenter.openWikipediaApp(with: location.coordinate)
                    }
                }
            }
            .navigationTitle("Places")
            .onAppear {
                Task {
                    await presenter.loadLocations()
                }
            }
        }
    }
}

struct SearchPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        let networkService = NetworkService()
        let service = SearchPlacesNetworkService(networkService: networkService)
        let interactor = SearchPlacesInteractor(service: service)
        let presenter = SearchPlacesPresenter(interactor: interactor)
        return SearchPlacesView(presenter: presenter)
    }
}
