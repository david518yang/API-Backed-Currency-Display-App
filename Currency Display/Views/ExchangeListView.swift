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
    @State var currencyDict = [String:String]()
    @State var completeBaseList = [String]()
    @State var chosenSymbol: "USD"
    @FocusState private var inputFocused: Bool
    
    func formRequest(showAll: Bool, currencies: [String]) async{
        do {
            let exchange = try await exchangeAmount(base: base,amount: amount)
            for currency in exchange.rates {
                if showAll {
                    currencyDict.updateValue("\(currency.value)", forKey: currency.key)
                }else if currencies.contains(currency.key){
                    currencyDict.updateValue("\(currency.value)", forKey: currency.key)
                }
                completeBaseList.self.append("\(currency.key)")
            }
            completeBaseList.self.sort()
        }catch{
            fatalError("error")
        }
    }
    
    func chooseFlag(key:String) -> String{
        if(key=="USD"){
            return "\u{1F1FA}\u{1F1F8}"
        }else if(key=="EUR"){
            return "\u{1F1EA}\u{1F1FA}"
        }else if(key=="JPY"){
            return "\u{1F1EF}\u{1F1F5}"
        }else if(key=="GBP"){
            return "\u{1F1EC}\u{1F1E7}"
        }else if(key=="CNY"){
            return "\u{1F1E8}\u{1F1F3}"
        }else if(key=="AUD"){
            return "\u{1F1E6}\u{1F1FA}"
        }else if(key=="CAD"){
            return "\u{1F1E8}\u{1F1E6}"
        }else if(key=="CHF"){
            return "\u{1F1E8}\u{1F1ED}"
        }else if(key=="HKD"){
            return "\u{1F1ED}\u{1F1F0}"
        }else if(key=="SGD"){
            return "\u{1F1F8}\u{1F1EC}"
        }else if(key=="SEK"){
            return "\u{1F1F8}\u{1F1EA}"
        }else if(key=="KRW"){
            return "\u{1F1F0}\u{1F1F7}"
        }else if(key=="NOK"){
            return "\u{1F1F3}\u{1F1F4}"
        }else if(key=="NZD"){
            return "\u{1F1F3}\u{1F1FF}"
        }else if(key=="INR"){
            return "\u{1F1EE}\u{1F1F3}"
        }else if(key=="MXN"){
            return "\u{1F1F2}\u{1F1FD}"
        }else if(key=="TWD"){
            return "\u{1F1F9}\u{1F1FC}"
        }else if(key=="ZAR"){
            return "\u{1F1FF}\u{1F1E6}"
        }else if(key=="BRL"){
            return "\u{1F1E7}\u{1F1F7}"
        }else if(key=="DKK"){
            return "\u{1F1E9}\u{1F1F0}"
        }else{
            return "\u{26FF}"
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
                ForEach(currencyDict.sorted(by:<), id: \.key) { key,value in
                    let flag = chooseFlag(key:key)
                    HStack{
                        Text(flag+key)
                        Spacer()
                        switch key{
                        case "USD","BRL","ETB","MOP","NIO","WST","TOP","MYR":
                            Text("$\(value)")
                        case "EUR":
                            Text("\u{20AC}\(value)")
                        case "GBP":
                            Text("\u{00AC}\(value)")
                        case "JPY":
                            Text("\u{00A5}\(value)")
                        case "CHF":
                            Text("\u{20A3}\(value)")
                        case "INR","IDR":
                            Text("\u{20B9}\(value)")
                        default:
                            Text(value)
                        }
                    }
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
                    Picker(selection:$base, label: Text("Currency Base")){
                        ForEach(completeBaseList, id: \.self){ base in
                            Text(base)
                        }
                    }
                    .frame(width: 350.0, height: 150)
                    .pickerStyle(.wheel)
                }
                
                NavigationView {
                    Form {
                        Section {
                            Picker(selection: $chosenSymbol, label: Text("Select Currency to Convert to")) {
                                ForEach(completeBaseList,id:\.self) { base in
                                    Text(base)
                                }
                          }
                     }.navigationBarTitle(Text("Currencies"), displayMode: .inline)
                }
                
                Button("Convert"){
                    refresh += 1
                }
            }
        }.task(id: refresh){
            await formRequest(showAll:true, currencies:[chosenSymbol])
        }
    }
}

struct ExchangeListView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeListView()
    }
}
