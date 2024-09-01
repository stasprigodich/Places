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
    
    init(with location: Location, locationService: LocationServiceProtocol = DI.location.locationServiceProtocol) async {
        if let locationName = location.name {
            name = locationName
        } else {
            let coordinate = location.coordinate
            let locationName = await locationService.getLocationName(latitude: coordinate.latitude, longitude: coordinate.longitude)
            name = locationName ?? String(format: Strings.SearchPlaces.defaultPlaceName, coordinate.latitude, coordinate.longitude)
        }
        coordinate = location.coordinate
    }
}
