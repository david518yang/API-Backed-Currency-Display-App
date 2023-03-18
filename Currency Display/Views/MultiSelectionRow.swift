//
//  MultiSelectionRow.swift
//  Currency Display
//
//  Created by Sung Jae Ko on 3/16/23.
//

import SwiftUI

struct MultiSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
