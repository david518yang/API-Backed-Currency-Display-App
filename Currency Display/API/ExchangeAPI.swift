//
//  ExchangerateAPI.swift
//  Currency Display
//
//  Created by David Yang on 2/20/23.
//

import Foundation

let EXCHANGERATE_API_ROOT = "https://api.exchangerate.host/"
let SEARCH_ENDPOINT = "\(EXCHANGERATE_API_ROOT)/latest"

enum ExchangeAPIError: Error {
    case unsuccessfulDecode
    case badUrl
}

func getRates(base: String, amount: Double) async throws -> ExchangeRate {
    guard let url = URL(string: "\(SEARCH_ENDPOINT)?symbols=USD,JPY&amount=\(amount)&base=\(base)") else {
        throw ExchangeAPIError.badUrl
    }

    let (data, _) = try await URLSession.shared.data(from: url)
    if let decodedPage = try? JSONDecoder().decode(ExchangeRate.self, from: data) {
        return decodedPage
    } else {
        throw ExchangeAPIError.unsuccessfulDecode
    }
//    guard let url = URL("\(SEARCH_ENDPOINT)?symbols=USD,JPY") else{
//        throw ExchangeAPIError.badUrl
//    }
//
//    let(data, _) = try await URLSession.shared.data(from:url)
//    if
}
