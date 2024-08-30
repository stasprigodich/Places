//
//  SearchPlacesEmptyView.swift
//  places
//
//  Created by Stan Prigodich on 30/08/2024.
//

import SwiftUI

struct SearchPlacesEmptyView: View {
    var body: some View {
        VStack {
            Spacer()
            ErrorStateView(message: "No locations found", retryAction: nil)
            Spacer()
        }
    }
}
