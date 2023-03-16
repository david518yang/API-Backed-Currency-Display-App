//
//  CurrencySelectionView.swift
//  Currency Display
//
//  Created by David Yang on 3/16/23.
//

import SwiftUI

struct CurrencySelectionView: View {
    var completeBaseList = [String]()
    @State var chosenSymbols = Set<String>()
    @State var isEditing = false
    
    var body: some View {
        NavigationView{
            List(selection: $chosenSymbols){
                ForEach(completeBaseList, id: \.self){ base in
                    Text(base)
                }
            }
            .navigationTitle("Selected \(chosenSymbols.count) currencies")
            .navigationBarItems(trailing:Button(action: {
                isEditing.toggle()
            },label:{
                if self.isEditing{
                    Text("Done")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }else{
                    Text("Edit")
                        .foregroundColor(.accentColor)
                }
            }))
            .listStyle(.inset)
            .environment(\.editMode, .constant(self.isEditing ? .active : .inactive))
            .animation(.spring(), value: isEditing )
        }
    }
}

struct CurrencySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySelectionView()
    }
}
