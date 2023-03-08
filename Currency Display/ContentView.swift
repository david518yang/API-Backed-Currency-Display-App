//
//  ContentView.swift
//  Currency Display
//
//  Created by David Yang on 2/20/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            ExchangeListView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
