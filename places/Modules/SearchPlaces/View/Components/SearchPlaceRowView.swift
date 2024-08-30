//
//  SearchPlaceRowView.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import SwiftUI

struct SearchPlaceRowView: View {
    let location: LocationViewModel
    let tapAction: () -> Void

    var body: some View {
        Button(action: tapAction) {
            Text(location.name)
        }
    }
}

struct SearchPlaceRowView_Previews: PreviewProvider {
    static var previews: some View {
        let location = LocationViewModel(name: "Amsterdam", coordinate: .init(latitude: 123, longitude: 123))
        SearchPlaceRowView(location: location) { }
    }
}
