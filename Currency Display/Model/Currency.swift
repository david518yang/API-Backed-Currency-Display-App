//
//  Currency.swift
//  Currency Display
//
//  Created by David Yang on 3/6/23.
//

import Foundation

struct Currency: Hashable, Codable {
    var baseSymbol: String
    var baseValue: Double
    var exchangedSymbol: String
    var exchangedValue: Double
}
