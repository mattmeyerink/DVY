//
//  SplitModalButtons.swift
//  DVY
//
//  Created by Matthew Meyerink on 6/3/22.
//

import SwiftUI

struct SplitModalButtons: View {
    @State var cancelAction: () -> Void
    @State var splitItemAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: cancelAction) {
                Text("Cancel")
            }
                .buttonStyle(RedButton())
            
            Spacer()
            
            Button(action: splitItemAction) {
                Text("Split")
            }
                .buttonStyle(GreenButton())
        }
            .padding()
    }
}
