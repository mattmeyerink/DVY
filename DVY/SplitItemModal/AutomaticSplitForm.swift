//
//  AutomaticSplitForm.swift
//  DVY
//
//  Created by Matthew Meyerink on 6/3/22.
//

import SwiftUI

struct AutomaticSplitForm: View {
    @Binding var friends: [Person]
    @Binding var items: [ReciptItem]
    @Binding var itemSplitIndex: Int?
    
    @State var applyToAll: Bool = false
    @State var closeSplitItemModal: () -> Void
    @State var calculateCostPerPerson: (Double) -> CurrencyObject
    
    var body: some View {
        VStack {
            Toggle("Apply to All Friends", isOn: $applyToAll)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
            
            if (!applyToAll) {
                ScrollView {
                    ForEach(friends.indices, id: \.self) { i in
                        HStack {
                            Text(friends[i].firstName + " " + friends[i].lastName)
                                .font(.system(size: 20, weight: .semibold))
                                .padding(.leading, 5)
                            
                            Spacer()
                        }
                            .padding()
                            .background(Color(red: friends[i].color.red, green: friends[i].color.green, blue: friends[i].color.blue))
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                            .cornerRadius(10)
                    }
                }
            } else {
                Text("Cost Per Person: \(calculateCostPerPerson(Double(friends.count)).priceFormatted)")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
            }
            
            SplitModalButtons(
                cancelAction: closeSplitItemModal,
                splitItemAction: closeSplitItemModal
            )
        }
            .padding(.horizontal)
    }
}
