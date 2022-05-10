//
//  ConfirmationFlowSummary.swift
//  DVY
//
//  Created by Matthew Meyerink on 5/3/22.
//

import SwiftUI

struct ConfirmationFlowSummary: View {
    @Binding var items: [ReciptItem]
    
    @State var returnToForm: () -> Void
    @State var confirmItemUpdates: () -> Void
    
    var body: some View {
        VStack {
            Text("New Item Count: " + String(items.count))
                .font(.system(size: 25, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top)
            
            Text("New Subtotal: " + calculateSubtotal().priceFormatted)
                .font(.system(size: 25, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            Spacer()
            
            HStack {
                Button (action: { returnToForm() } ){
                    Text("Back")
                }
                    .buttonStyle(RedButton())
                
                Spacer()
                
                Button (action: { confirmItemUpdates() }) {
                    Text("Confirm")
                }
                    .buttonStyle(GreenButton())
            }
                .padding(.bottom)
                .padding(.horizontal)
        }
    }
    
    func calculateSubtotal() -> CurrencyObject {
        var total = 0.0
        for item in items {
            total += item.price
        }
        return CurrencyObject(price: total)
    }
}
