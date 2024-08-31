//
//  SearchPlacesErrorView.swift
//  places
//
//  Created by Stan Prigodich on 30/08/2024.
//

import SwiftUI

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

struct SearchPlacesErrorView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlacesErrorView(message: "Failed to load places") { }
    }
}
