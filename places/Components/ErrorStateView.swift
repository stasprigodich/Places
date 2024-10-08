//
//  ErrorStateView.swift
//  places
//
//  Created by Stan Prigodich on 30/08/2024.
//

import SwiftUI

struct ErrorStateView: View {
    let message: String
    let retryAction: (() -> Void)?

    var body: some View {
        VStack {
            Text(message)
                .multilineTextAlignment(.center)
                .padding()
            
            if let retryAction = retryAction {
                Button(Strings.ErrorStateView.retryButton) {
                    retryAction()
                }
                .padding()
            }
        }
        .accessibilityIdentifier(AccessibilityIdentifiers.ErrorStateView.view)
    }
}

struct ErrorStateView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorStateView(message: "Failed to load places") { }
    }
}
