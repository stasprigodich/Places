//
//  SearchTextField.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import SwiftUI
import Combine

struct SearchTextField: View {
    @Binding var text: String
    var onSubmit: () -> Void
    
    @State private var debounceTimer: AnyCancellable?
    @State private var debouncedText: String = ""

    var body: some View {
        TextField("Search...", text: $debouncedText)
            .autocorrectionDisabled()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onChange(of: debouncedText) { newValue in
                debounceTextInput(newValue)
            }
            .onSubmit {
                onSubmit()
            }
    }
    
    private func debounceTextInput(_ newValue: String) {
        debounceTimer?.cancel()
        debounceTimer = Just(newValue)
            .delay(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { _ in
                text = newValue
                onSubmit()
            }
    }
}

struct SearchTextField_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextField(text: .constant("")) { }
    }
}
