//
//  Currency.swift
//  Currency Display
//
//  Created by David Yang on 3/6/23.
//

import Foundation

struct Currency: Hashable, Codable {
    var success: Bool
    var base: String
    var date : String
    var rates = [String: Double]()
}
