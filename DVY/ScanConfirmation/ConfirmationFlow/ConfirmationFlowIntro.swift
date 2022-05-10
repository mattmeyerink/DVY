//
//  ConfirmationFlowIntro.swift
//  DVY
//
//  Created by Matthew Meyerink on 5/3/22.
//

import SwiftUI

struct ConfirmationFlowIntro: View {
    @State var closeConfirmationFlow: () -> Void
    @State var continueToForm: () -> Void
    
    var body: some View {
        VStack {
            Text("This is a flow to correct and confirm the items from the receipt. When you click continue, items scanned from the receipt will be displayed one by one in order. At each item you can delete the item, edit the item, or insert a missed item before selecting next to continue. At the end, confirm you want to accept the new item count and total.")
                .font(.system(size: 20, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            Spacer()
            
            HStack {
                Button (action: { closeConfirmationFlow() } ){
                    Text("Cancel")
                }
                    .buttonStyle(RedButton())
                
                Spacer()
                
                Button (action: { continueToForm() }) {
                    Text("Continue")
                }
                    .buttonStyle(GreenButton())
            }
                .padding(.bottom)
                .padding(.horizontal)
        }
    }
}
