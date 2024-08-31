//
//  SearchPlaces+ViewState.swift
//  places
//
//  Created by Stan Prigodich on 30/08/2024.
//

enum SearchPlacesViewState: Equatable {
    case loading
    case error(String)
    case empty(String)
    case results([LocationViewModel])
}
