//
//  Config.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import Foundation

@dynamicMemberLookup
struct Config {
    
    let baseStringUrl = "https://demo4898023.mockable.io/"
    
    /// Prevent outside construction
    private init() { }
    
    static subscript<T>(dynamicMember keyPath: KeyPath<Config, T>) -> T {
        Config()[keyPath: keyPath]
    }
}
