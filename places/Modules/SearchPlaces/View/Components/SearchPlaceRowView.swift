//
//  SearchPlaceRowView.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import SwiftUI

// MARK: - SearchPlaceRowView

struct SearchPlaceRowView: View {
    let location: LocationViewModel
    let tapAction: () -> Void

    var body: some View {
        Button(action: tapAction) {
            Text(location.name)
        }
        .accessibilityIdentifier(
            String(format: AccessibilityIdentifiers.SearchPlaces.row, location.id.uuidString)
        )
        .accessibilityHint(Strings.SearchPlaceRowView.accessibilityHint)
    }
}

// MARK: - Preview

struct SearchPlaceRowView_Previews: PreviewProvider {
    static var previews: some View {
        let location = LocationViewModel(
            name: "Amsterdam", 
            coordinate: .init(latitude: 0, longitude: 0)
        )
        SearchPlaceRowView(location: location) { }
    }
}
