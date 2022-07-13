//
//  FriendItemList.swift
//  DVY
//
//  Created by Matthew Meyerink on 11/23/21.
//

import SwiftUI

struct FriendItemListModal: View {
    @Binding var friendIndex: Int?
    @Binding var friends: [Person]
    @Binding var items: [ReciptItem]
    @Binding var isFriendItemListOpen: Bool
    @Binding var modalTitle: String
    
    @State var showingDeleteIndex: Int? = nil
    @State var otherModalOpening: Bool = false
    
    var body: some View {
        Modal(
            modalTitle: $modalTitle,
            otherModalOpening: $otherModalOpening,
            closeModal: closeItemListModal,
            modalHeight: 450
        ) {
            VStack {
                if let f = friends[friendIndex!] {
                    ScrollView {
                        ForEach(f.items.indices, id: \.self) { i in
                            VStack {
                                HStack {
                                    Text(f.items[i].name)
                                        .font(.system(size: 20, weight: .semibold))
                                        .padding(.leading, 5)
                                    
                                    Spacer()
                                    
                                    if (i == showingDeleteIndex) {
                                        Image(systemName: "trash.fill")
                                            .font(.system(size: 20, weight: .semibold))
                                            .padding(.horizontal, 5)
                                            .onTapGesture() {
                                                deleteItem(itemIndex: i)
                                            }
                                    } else {
                                        Text(f.items[i].priceFormatted)
                                            .font(.system(size: 20, weight: .semibold))
                                            .padding(.horizontal, 5)
                                    }
                                }
                            }
                                .padding()
                                .background(Color(red: 0.95, green: 0.8, blue: 0.5))
                                .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                                .cornerRadius(10)
                                .onTapGesture {
                                    toggleShowingDelete(itemIndex: i)
                                }
                        }
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text("Subtotal: " + calculateSubTotal())
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(Color.white)
                    }
                }
            }
                .padding()
        }
    }
    
    func toggleShowingDelete(itemIndex: Int) {
        if (itemIndex == showingDeleteIndex) {
            showingDeleteIndex = nil
        } else {
            showingDeleteIndex = itemIndex
        }
    }
    
    func deleteItem(itemIndex: Int) {
        items.append(friends[friendIndex!].items[itemIndex])
        friends[friendIndex!].items.remove(at: itemIndex)
        
        if friends[friendIndex!].items.count == 0 {
            isFriendItemListOpen = false
        }
    }
    
    func calculateSubTotal() -> String {
        if let i = friendIndex {
            var total = 0.0
            for item in friends[i].items {
                total += item.price
            }
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            return formatter.string(from: NSNumber(value: total)) ?? "$0.00"
        }
        
        return "$0.00"
    }
    
    func closeItemListModal() {
        isFriendItemListOpen = false
    }
}
