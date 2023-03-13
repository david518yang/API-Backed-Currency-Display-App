//
//  ExchangeListView.swift
//  Currency Display
//
//  Created by David Yang on 2/20/23.
//

import SwiftUI


struct ExchangeListView: View {
    @State var base = "USD"
    @State var amount = 100.0
    @State var currencyList = [String]()
    @FocusState private var inputFocused: Bool
    
    func formRequest(showAll: Bool, currencies: [String] = ["USD", "EUR", "JPY"]) async{
        do {
            let exchange = try await exchangeAmount(base: base,amount: amount)
            
            var tempList = [String]()
            for currency in exchange.rates {
                if showAll {
                    tempList.append("\(currency.key) \(String(format: "%.2f", currency.value))")
                }else if currencies.contains(currency.key){
                    tempList.append("\(currency.key) \(String(format: "%.2f", currency.value))")
                }
                tempList.sort()
            }
            currencyList.self = tempList
            print(tempList)
        }catch{
            fatalError("error")
        }
    }
    
    var body: some View {
        Text("Hello World!")
            .padding()
            .onAppear(){
                formRequest(showAll: false)
            }
    }
}

struct ExchangeListView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeListView()
    }
}
