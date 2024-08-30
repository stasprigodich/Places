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

                ZStack {
                    Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all)

                    if presenter.isLoading {
                        VStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    } else if let errorMessage = presenter.errorMessage {
                        VStack {
                            Spacer()
                            ErrorStateView(message: errorMessage) {
                                Task {
                                    await presenter.loadLocations()
                                }
                            }
                            Spacer()
                        }
                    } else if presenter.filteredLocations.isEmpty {
                        VStack {
                            Spacer()
                            ErrorStateView(message: "No locations found", retryAction: nil)
                            Spacer()
                        }
                    } else {
                        List(presenter.filteredLocations) { location in
                            SearchPlaceRowView(location: location) {
                                presenter.openWikipediaApp(with: location.coordinate)
                            }
                            .listRowBackground(Color(UIColor.white))
                        }
                    }
                }
            }
            .navigationTitle("Places")
            .alert(isPresented: $presenter.showWikipediaAppAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Wikipedia app is not installed."),
                    dismissButton: .default(Text("OK"))
                )
            }
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
        let presenter = SearchPlacesPresenter(
            interactor: DI.searchPlaces.searchPlacesInteractorProtocol,
            router: DI.searchPlaces.searchPlacesRouterProtocol
        )
        return SearchPlacesView(presenter: presenter)
    }
}
