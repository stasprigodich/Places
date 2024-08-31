//
//  LocationDTO.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

struct LocationsResponseDTO: Codable {
    let locations: [LocationDTO]
}

struct LocationDTO: Codable {
    let name: String?
    let lat: Double
    let long: Double
}

extension LocationsResponseDTO {
    
    func convertToEntity() -> [Location] {
        locations.map {
            .init(
                name: $0.name,
                coordinate: .init(
                    latitude: $0.lat,
                    longitude: $0.long
                )
            )
        }
    }
}
