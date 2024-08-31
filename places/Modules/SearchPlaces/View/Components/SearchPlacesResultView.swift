//
//  SearchPlacesResultView.swift
//  places
//
//  Created by Stan Prigodich on 30/08/2024.
//

import SwiftUI

struct SearchPlacesResultView: View {
    let locations: [LocationViewModel]
    let onSelectLocation: (Coordinate) -> Void

    var body: some View {
        List(locations) { location in
            SearchPlaceRowView(location: location) {
                onSelectLocation(location.coordinate)
            }
            .listRowBackground(Color(.secondarySystemGroupedBackground))
        }
    }
}

struct SearchPlacesResultView_Previews: PreviewProvider {
    static var previews: some View {
        let locations = [
            LocationViewModel(
                name: "Amsterdam",
                coordinate: .init(latitude: 0, longitude: 0)
            )
        ]
        SearchPlacesResultView(locations: locations) { _ in }
    }
}
