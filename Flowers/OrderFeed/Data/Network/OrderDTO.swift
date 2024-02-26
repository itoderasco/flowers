//
//  OrderDTO.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import Foundation

struct OrderDTO: Decodable {
    let id: Int
    let description: String
    let price: Double
    let customer_id: Int
    let image_url: URL?
    let status: String
}
