//
//  MultipleSelectionList.swift
//  Currency Display
//
//  Created by Sung Jae Ko on 3/16/23.
//

import SwiftUI

struct MultipleSelectionList: View {
    @State var completeBaseList = [String]()
    //@Binding var chosenSymbols: Set<String>
    @State var selections: [String] = []

    var body: some View {
        List {
            ForEach(self.completeBaseList, id: \.self) { item in
                MultiSelectionRow(title: item, isSelected: self.selections.contains(item)) {
                    if self.selections.contains(item) {
                        self.selections.removeAll(where: { $0 == item })
                    }
                    else {
                        self.selections.append(item)
                    }
                }
            }
        }
    }
}

struct MultipleSelectionList_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSelectionList()
    }
}
