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

func getBaseList() async throws -> [String] {
    var completeBaseList = [String]()
    
    guard let url = URL(string: LATEST_ENDPOINT) else {
        throw ExchangeAPIError.badUrl
    }
    let (data, _) = try await URLSession.shared.data(from: url)
    if let decodedPage = try? JSONDecoder().decode(Currency.self, from: data) {
        for currency in decodedPage.rates{
                completeBaseList.append(currency.key)
        }
        completeBaseList.sort()
        return completeBaseList
    } else {
        throw ExchangeAPIError.unsuccessfulDecode
    }
}

func exchangeAmount(base: String, amount: String) async throws -> Currency {
    //&symbols=\(symbols)
    guard let url = URL(string: "\(LATEST_ENDPOINT)?base=\(base)&amount=\(amount)") else {
        throw ExchangeAPIError.badUrl
    }

    let (data, _) = try await URLSession.shared.data(from: url)
    if let decodedPage = try? JSONDecoder().decode(Currency.self, from: data) {
        return decodedPage
    } else {
        throw ExchangeAPIError.unsuccessfulDecode
    }
}
