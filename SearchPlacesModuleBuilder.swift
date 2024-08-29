//
//  PlacesModuleBuilder.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import SwiftUI

struct SearchPlacesModuleBuilder {

    @MainActor static func build() -> some View {
        let presenter = SearchPlacesPresenter(
            interactor: DI.searchPlaces.searchPlacesInteractorProtocol,
            router: DI.searchPlaces.searchPlacesRouterProtocol
        )
        return SearchPlacesView(presenter: presenter)
    }
}
