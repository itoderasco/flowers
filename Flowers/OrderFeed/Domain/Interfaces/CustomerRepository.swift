//
//  CustomerRepository.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import Foundation

protocol CustomerRepository {
    func fetchCustomers() async throws -> [Customer]
}
