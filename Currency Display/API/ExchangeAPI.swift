//
//  ExchangerateAPI.swift
//  Currency Display
//
//  Created by David Yang on 2/20/23.
//

import Foundation

let EXCHANGERATE_API_ROOT = "https://api.exchangerate.host/"
let LATEST_ENDPOINT = "\(EXCHANGERATE_API_ROOT)/latest"

enum ExchangeAPIError: Error {
    case unsuccessfulDecode
    case badUrl
}

func getRates(base: String, symbols: String) async throws -> ExchangeRate {
    guard let url = URL(string: "\(LATEST_ENDPOINT)?symbols=\(symbols)&base=\(base)") else {
        throw ExchangeAPIError.badUrl
    }

    let (data, _) = try await URLSession.shared.data(from: url)
    if let decodedPage = try? JSONDecoder().decode(ExchangeRate.self, from: data) {
        return decodedPage
    } else {
        throw ExchangeAPIError.unsuccessfulDecode
    }
}

func exchangeAmount(base: String, symbols: String, amount: Double) async throws -> ExchangeRate {
    guard let url = URL(string: "\(LATEST_ENDPOINT)?base=\(base)&symbols=\(symbols)&amount=\(amount)") else {
        throw ExchangeAPIError.badUrl
    }

    let (data, _) = try await URLSession.shared.data(from: url)
    if let decodedPage = try? JSONDecoder().decode(ExchangeRate.self, from: data) {
        return decodedPage
    } else {
        throw ExchangeAPIError.unsuccessfulDecode
    }
}
