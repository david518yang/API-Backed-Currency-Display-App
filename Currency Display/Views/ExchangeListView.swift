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
                Text(rates.base)
                
            }else{
                ProgressView()
            }
        }
        .task(id: "1"){
            do{
                rates = try await getRates(base:"USD",symbols:"EUR,JPY")
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
