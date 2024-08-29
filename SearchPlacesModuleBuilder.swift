//
//  PlacesModuleBuilder.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import SwiftUI

struct SearchPlacesModuleBuilder {
    @MainActor static func build() -> some View {
        let networkService = NetworkService()
        let service = SearchPlacesNetworkService(networkService: networkService)
        let interactor = SearchPlacesInteractor(service: service)
        let presenter = SearchPlacesPresenter(interactor: interactor)
        return SearchPlacesView(presenter: presenter)
    }
}
