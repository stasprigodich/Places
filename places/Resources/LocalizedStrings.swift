//
//  LocalizedStrings.swift
//  places
//
//  Created by Stan Prigodich on 31/08/2024.
//

import Foundation

enum Strings {
    
    enum SearchPlaces {
        static let title = "SearchPlaces.title".localized
        static let emptyMessage = "SearchPlaces.emptyMessage".localized
        static let errorMessage = "SearchPlaces.errorMessage".localized
        static let defaultPlaceName = "SearchPlaces.defaultPlaceName".localized
        static let accessibilityLoading = "SearchPlaces.accessibility.loading".localized
        static let accessibilityEmpty = "SearchPlaces.accessibility.empty".localized
        static let accessibilityError = "SearchPlaces.accessibility.error".localized
        static let accessibilityResult = "SearchPlaces.accessibility.result".localized
    }
    
    enum SearchPlaceRowView {
        static let accessibilityHint = "SearchPlaceRowView.accessibility.accessibilityHint".localized
    }
    
    enum SearchTextField {
        static let placeholder = "SearchTextField.placeholder".localized
        static let accessibilityLabel = "SearchTextField.accessibility.accessibilityLabel".localized
        static let accessibilityHint = "SearchTextField.accessibility.accessibilityHint".localized
    }
    
    enum ErrorStateView {
        static let retryButton = "ErrorStateView.retryButton".localized
    }

    enum WikipediaAppAlert {
        static let message = "WikipediaAppAlert.message".localized
    }
    
    enum General {
        static let okay = "General.okay".localized
        static let error = "General.error".localized
    }
}

private extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
