//
//  CurrencySelectionView.swift
//  Currency Display
//
//  Created by David Yang on 3/16/23.
//

import SwiftUI

struct CurrencySelectionView: View {
    var completeBaseList = [String]()
    @Binding var chosenSymbols: Set<String>
    @Environment(\.editMode) var isEditing
    
    var body: some View {
        NavigationView{
            List(selection: $chosenSymbols){
                ForEach(completeBaseList, id: \.self){ base in
                    Text(base)
                }
            }
            .navigationTitle("Selected \(chosenSymbols.count) currencies")
            
            .navigationBarItems(trailing: EditButton())
            .listStyle(.inset)

            .animation(.spring(), value: isEditing?.wrappedValue.isEditing )
        }
    }
}

struct CurrencySelectionView_Previews: PreviewProvider {
//    var set = Set<String>()
    static var previews: some View {
//        CurrencySelectionView(completeBaseList: [
//            "USD",
//            "Simoleons",
//            "Star Wars Credits",
//            "Gold Pieces"
//        ], chosenSet: $set)
        Text("TBD")
    }
}
