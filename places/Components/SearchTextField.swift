//
//  SearchTextField.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var text: String
    var onSubmit: () -> Void

    var body: some View {
        TextField("Search...", text: $text)
            .autocorrectionDisabled()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onSubmit {
                onSubmit()
            }
    }
}

struct SearchTextField_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextField(text: .constant("")) { }
    }
}
