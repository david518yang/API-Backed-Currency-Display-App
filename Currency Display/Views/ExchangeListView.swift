//
//  ExchangeListView.swift
//  Currency Display
//
//  Created by David Yang on 2/20/23.
//

import SwiftUI


struct ExchangeListView: View {
    @State var rates : ExchangeRate?
    var body: some View {
        ScrollView{
            
            if let rates {
                Text("Base: \(rates.base)")
                Text("Date: \(rates.date)")
                Spacer()
                Text("1 \(rates.base) is equal to ...")
            }else{
                ProgressView()
            }
        }
        .task(id: "1"){
            do{
                rates = try await getRates(base:"USD",symbols:"EUR,JPY")
                print(rates as Any)
            }catch{
                fatalError("error")
            }
        }
    }
        
}

struct ExchangeListView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeListView()
    }
}
