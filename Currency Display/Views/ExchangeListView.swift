//
//  ExchangeListView.swift
//  Currency Display
//
//  Created by David Yang on 2/20/23.
//

import SwiftUI
import ConfettiSwiftUI


struct ExchangeListView: View {
    @State var base = "USD"
    @State var amount = "100.00"
    @State var refresh = 0
    @State var currencyDict = [String:String]()
    @State var tempBaseList = [String]()
    @State var completeBaseList = [String]()
    @State var chosenSymbols = [String]()
    @State var showAll = false
    @FocusState private var inputFocused: Bool
    @State var selections: [String] = []
    
    func formRequest(showAll: Bool, currencies: [String]) async{
        do {
            let exchange = try await exchangeAmount(base: base,amount: amount)
            tempBaseList.removeAll()
            for currency in exchange.rates {
                if showAll {
                    currencyDict.updateValue("\(String(format: "%.2f",currency.value))", forKey: currency.key)
                }else if currencies.contains(currency.key){
                    currencyDict.updateValue("\(String(format: "%.2f",currency.value))", forKey: currency.key)
                }
                tempBaseList.self.append(currency.key)
                tempBaseList.sort()
            }
            completeBaseList = tempBaseList
            
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
        NavigationView {
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
                            case "USD","AUD","CAD","BRL","ETB","MOP","NIO","WST","TOP","MYR":
                                Text("$\(value)")
                            case "EUR":
                                Text("\u{20AC}\(value)")
                            case "GBP":
                                Text("\u{00A3}\(value)")
                            case "JPY":
                                Text("\u{00A5}\(value)")
                            case "CHF":
                                Text("\u{20A3}\(value)")
                            case "INR","IDR":
                                Text("\u{20B9}\(value)")
                            case "KRW":
                                Text("\u{20A9}\(value)")
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
                    
                    HStack{
                        //Amount Selection
                        VStack{
                            Text("Amount to convert")
                                .font(.title3)
                            TextField("Amount",text:$amount)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(50)
                                .padding()
                                .keyboardType(.decimalPad)
                                .focused($inputFocused)
                        }
                        //Base Selection
                        VStack {
                            Text("Currency Base")
                                .font(.title3)
                            List{
                                Picker("Currency Base", selection:$base){
                                    ForEach(completeBaseList, id: \.self){ base in
                                        Text(base)
                                    }
                                }
                                .frame(width: 150, height: 80)
                                .pickerStyle(.wheel)
                            }
                        }
                    }.frame(height:190)
                    
                    //Currency Conversion Selection
                    NavigationLink("Select Currencies to Convert to"){
                        List {
//                            Toggle("Choose All Currencies", isOn:$showAll)
                            
                            ForEach(completeBaseList, id: \.self) { item in
                                MultiSelectionRow(title: item, isSelected: self.chosenSymbols.contains(item)) {
                                    if self.chosenSymbols.contains(item) {
                                        self.chosenSymbols.removeAll(where: { $0 == item })
                                    }
                                    else {
                                        self.chosenSymbols.append(item)
                                    }
                                }
                            }
                        }.navigationTitle("Selected \(chosenSymbols.count) currencies")
                    }
                    .frame(width:400,height:50)
                    .buttonStyle(.borderedProminent)
                    .font(.headline)
                    .cornerRadius(20)
                    
                    //Convert Button
                    Button("Convert!"){
                        refresh+=1
                    }.confettiCannon(counter: $refresh, num:1, confettis: [.text("\u{1F4B5}"), .text("\u{1F4B6}"), .text("\u{1F4B7}"), .text("\u{1F4B4}")], confettiSize: 30, repetitions: 10, repetitionInterval: 0.1)
                        .buttonStyle(.bordered)
                        .foregroundColor(.green)
                }
            }.task(id: refresh){
                await formRequest(showAll:showAll, currencies:chosenSymbols)
            }
        }
    }
}
struct ExchangeListView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeListView()
    }
}
