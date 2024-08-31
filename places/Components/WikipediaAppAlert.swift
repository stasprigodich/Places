//
//  WikipediaAppAlert.swift
//  places
//
//  Created by Stan Prigodich on 31/08/2024.
//

import SwiftUI

struct WikipediaAppAlert {
    static func build() -> Alert {
        return Alert(
            title: Text(Strings.General.error),
            message: Text(Strings.WikipediaAppAlert.message),
            dismissButton: .default(Text(Strings.General.okay))
        )
    }
}
