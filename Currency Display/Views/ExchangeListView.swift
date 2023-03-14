//
//  ExchangeListView.swift
//  Currency Display
//
//  Created by David Yang on 2/20/23.
//

import SwiftUI


struct ExchangeListView: View {
    @State var base = "USD"
    @State var amount = "100.00"
    @State var refresh = 0
    @State var currencyList = [String]()
    @State var baseList = [String]()
    @FocusState private var inputFocused: Bool
    
    func formRequest(showAll: Bool, currencies: [String]) async{
        do {
            let exchange = try await exchangeAmount(base: base,amount: amount)
            
            var tempList = [String]()
            for currency in exchange.rates {
                if showAll {
                    tempList.append("\(currency.key) \(String(format: "%.2f", currency.value))")
                }else if currencies.contains(currency.key){
                    tempList.append("\(currency.key) \(String(format: "%.2f", currency.value))")
                }
                baseList.self.append("\(currency.key)")
                tempList.sort()
                baseList.self.sort()
            }
            currencyList.self = tempList
        }catch{
            fatalError("error")
        }
    }
    
    var body: some View {
        VStack {
            //Headline
            HStack{
                Text("Currency Display")
                    .font(.system(size:25))
                    .bold()
                Image(systemName: "dollarsign.circle.fill")
                    .font(.system(size:25))
                    .foregroundColor(.green)
            }
            
            //Currency List
            List{
                ForEach(currencyList, id: \.self) { currency in
                    Text(currency)
                }
            }
            
            //User Entry
            VStack{
                Rectangle()
                    .frame(height:8.0)
                    .foregroundColor(.accentColor)
                    .opacity(0.7)
                TextField("Amount to convert",text:$amount)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(50)
                    .padding()
                    .keyboardType(.decimalPad)
                    .focused($inputFocused)
//                TextField("Currency Base",text:$base)
//                    .padding()
//                    .background(Color.gray.opacity(0.2))
//                    .cornerRadius(50)
//                    .padding()
//                    .focused($inputFocused)
                List{
                    Picker("Currency Base",selection:$base){
                        ForEach(baseList, id: \.self){ base in
                            Text(base)
                        }
                    }
                    .frame(width: 350.0, height: 150)
                    .pickerStyle(.wheel)
                }
                Button("Convert"){
                    refresh += 1
                }
            }
        }.task(id: refresh){
            await formRequest(showAll:true, currencies:["USD", "EUR", "JPY"])
        }
        
        
    }
}

struct ExchangeListView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeListView()
    }
}
