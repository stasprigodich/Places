//
//  SearchPlacesErrorView.swift
//  places
//
//  Created by Stan Prigodich on 30/08/2024.
//

import SwiftUI

// MARK: - SearchPlacesErrorView

struct SearchPlacesErrorView: View {
    let message: String
    let retryAction: () -> Void

    var body: some View {
        VStack {
            Spacer()
            ErrorStateView(message: message, retryAction: retryAction)
            Spacer()
        }
    }
}

// MARK: - Preview

struct SearchPlacesErrorView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlacesErrorView(message: "Failed to load places") { }
    }
}
