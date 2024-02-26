//
//  CustomerDTO.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import Foundation

struct CustomerDTO: Decodable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
}
