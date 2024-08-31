//
//  SearchPlacesEmptyView.swift
//  places
//
//  Created by Stan Prigodich on 30/08/2024.
//

import SwiftUI

struct SearchPlacesEmptyView: View {
    let message: String
    var body: some View {
        VStack {
            Spacer()
            ErrorStateView(message: message, retryAction: nil)
            Spacer()
        }
    }
}

struct SearchPlacesEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlacesEmptyView(message: "No places found")
    }
}
