//
//  AutomaticSplitForm.swift
//  DVY
//
//  Created by Matthew Meyerink on 6/3/22.
//

import SwiftUI

struct AutomaticSplitForm: View {
    var closeSplitItemModal: () -> Void
    
    var body: some View {
        Text("This will be the automatic split form!")
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(.white)
            .padding(.top, 15)
        
        SplitModalButtons(
            cancelAction: closeSplitItemModal,
            splitItemAction: closeSplitItemModal
        )
    }
}
