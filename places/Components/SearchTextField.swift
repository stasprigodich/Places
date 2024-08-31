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
    var onSubmit: (String) -> Void
    
    @State private var debounceTimer: AnyCancellable?
    @State private var debouncedText: String = ""

    var body: some View {
        TextField(Strings.SearchTextField.placeholder, text: $debouncedText)
            .autocorrectionDisabled()
            .submitLabel(.search)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onChange(of: debouncedText) { newValue in
                debounceTextInput(newValue)
            }
            .onSubmit {
                onSubmit(debouncedText)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityIdentifier(AccessibilityIdentifiers.SearchTextField.view)
            .accessibilityLabel(Strings.SearchTextField.accessibilityLabel)
            .accessibilityHint(Strings.SearchTextField.accessibilityHint)
            .accessibilityAddTraits(.isSearchField)
    }
    
    private func debounceTextInput(_ newValue: String) {
        debounceTimer?.cancel()
        debounceTimer = Just(newValue)
            .delay(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { _ in
                text = newValue
            }
    }
}

struct SearchTextField_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextField(text: .constant("")) { _ in }
    }
}
