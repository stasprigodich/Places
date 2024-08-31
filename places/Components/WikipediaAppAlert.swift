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
            title: Text("Error"),
            message: Text("Wikipedia app is not installed."),
            dismissButton: .default(Text("OK"))
        )
    }
}
