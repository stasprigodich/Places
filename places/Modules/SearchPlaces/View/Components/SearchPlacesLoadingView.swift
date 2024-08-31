//
//  SearchPlacesLoadingView.swift
//  places
//
//  Created by Stan Prigodich on 30/08/2024.
//

import SwiftUI

// MARK: - SearchPlacesLoadingView

struct SearchPlacesLoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}

// MARK: - Preview

struct SearchPlacesLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlacesLoadingView()
    }
}
