//
//  LocationViewModel.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import Foundation

struct LocationViewModel: Identifiable, Equatable {
    var id = UUID()
    let name: String
    let coordinate: Coordinate
    
    static func == (lhs: LocationViewModel, rhs: LocationViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

extension LocationViewModel {
    
    init(with location: Location) {
        name = location.name ?? "Place at (\(location.coordinate.latitude), \(location.coordinate.longitude))"
        coordinate = location.coordinate
    }
}
