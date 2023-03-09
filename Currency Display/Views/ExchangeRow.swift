//
//  ExchangeDetail.swift
//  Currency Display
//
//  Created by David Yang on 3/6/23.
//

import SwiftUI

struct ExchangeRow: View {
    var currency: Currency
    var body: some View {
        HStack{
            //flag
            if(currency.exchangedSymbol=="USD"){
                Text("\u{1F1FA}\u{1F1F8}")
            }else if(currency.exchangedSymbol=="EUR"){
                Text("\u{1F1EA}\u{1F1FA}")
            }else if(currency.exchangedSymbol=="JPY"){
                Text("\u{1F1EF}\u{1F1F5}")
            }else if(currency.exchangedSymbol=="GBP"){
                Text("\u{1F1EC}\u{1F1E7}")
            }else if(currency.exchangedSymbol=="CNY"){
                Text("\u{1F1E8}\u{1F1F3}")
            }else if(currency.exchangedSymbol=="AUD"){
                Text("\u{1F1E6}\u{1F1FA}")
            }else if(currency.exchangedSymbol=="CAD"){
                Text("\u{1F1E8}\u{1F1E6}")
            }else if(currency.exchangedSymbol=="CHF"){
                Text("\u{1F1E8}\u{1F1ED}")
            }else if(currency.exchangedSymbol=="HKD"){
                Text("\u{1F1ED}\u{1F1F0}")
            }else if(currency.exchangedSymbol=="SGD"){
                Text("\u{1F1F8}\u{1F1EC}")
            }else if(currency.exchangedSymbol=="SEK"){
                Text("\u{1F1F8}\u{1F1EA}")
            }else if(currency.exchangedSymbol=="KRW"){
                Text("\u{1F1F0}\u{1F1F7}")
            }else if(currency.exchangedSymbol=="NOK"){
                Text("\u{1F1F3}\u{1F1F4}")
            }else if(currency.exchangedSymbol=="NZD"){
                Text("\u{1F1F3}\u{1F1FF}")
            }else if(currency.exchangedSymbol=="INR"){
                Text("\u{1F1EE}\u{1F1F3}")
            }else if(currency.exchangedSymbol=="MXN"){
                Text("\u{1F1F2}\u{1F1FD}")
            }else if(currency.exchangedSymbol=="TWD"){
                Text("\u{1F1F9}\u{1F1FC}")
            }else if(currency.exchangedSymbol=="ZAR"){
                Text("\u{1F1FF}\u{1F1E6}")
            }else if(currency.exchangedSymbol=="BRL"){
                Text("\u{1F1E7}\u{1F1F7}")
            }else if(currency.exchangedSymbol=="DKK"){
                Text("\u{1F1E9}\u{1F1F0}")
            }else{
                Text("\u{2690}")
            }
            Text(currency.exchangedSymbol)
            Spacer()
            Text(currency.exchangedValue)
        }
    }
}

struct ExchangeRow_Previews: PreviewProvider {
    static var currency: Currency
    
    static var previews: some View {
        ExchangeRow()
    }
}
