//
//  ManualSplitForm.swift
//  DVY
//
//  Created by Matthew Meyerink on 6/3/22.
//

import SwiftUI

struct ManualSplitForm: View {
    @Binding var items: [ReciptItem]
    @Binding var itemSplitIndex: Int?
    
    @State var numberOfPeople: Int = 2
    @State var closeSplitItemModal: () -> Void
    @State var calculateCostPerPerson: (Double) -> CurrencyObject
    
    var body: some View {
        HStack {
            Text("Number of People: \(numberOfPeople)")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
            
            Spacer()
            
            Stepper("", value: $numberOfPeople, in: 2...100, step: 1)
                .frame(width: 100, height: 35)
                .offset(x: -4)
                .background(Color(red: 0.2, green: 0.9, blue: 0.25))
                .cornerRadius(8)
        }
            .padding(.horizontal)
       
        Text("Cost Per Person: \(calculateCostPerPerson(Double(numberOfPeople)).priceFormatted)")
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(.white)
            .padding(.horizontal)
        
        Spacer()
        
        SplitModalButtons(
            cancelAction: closeSplitItemModal,
            splitItemAction: splitItem
        )
    }
    
    func splitItem() {
        closeSplitItemModal()
        items[itemSplitIndex!].price = calculateCostPerPerson(Double(numberOfPeople)).price
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        items[itemSplitIndex!].priceFormatted = formatter.string(from: NSNumber(value: items[itemSplitIndex!].price)) ?? "$0"
        
        for _ in 0...(numberOfPeople - 2) {
            let newItem = ReciptItem(name: items[itemSplitIndex!].name, price: items[itemSplitIndex!].price)
            items.insert(newItem, at: itemSplitIndex!)
        }
    }
}
