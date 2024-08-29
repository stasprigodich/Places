//
//  LocationViewModel.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import Foundation

struct LocationViewModel: Identifiable {
    var id = UUID()
    let name: String?
    let coordinate: Coordinate
}

extension LocationViewModel {
    
    init(with location: Location) {
        name = location.name
        coordinate = location.coordinate
    }
}
