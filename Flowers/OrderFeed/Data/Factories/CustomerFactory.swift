//
//  CustomerFactory.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import Foundation

final class CustomerFactory {
    
    static func transform(_ dto: CustomerDTO) -> Customer {
        return .init(
            id: dto.id,
            name: dto.name,
            coordinate: (dto.latitude, dto.longitude)
        )
    }
}
