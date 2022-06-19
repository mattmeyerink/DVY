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
    @Binding var applyToAll: Bool
    
    @State var closeSplitItemModal: () -> Void
    @State var calculateCostPerPerson: (Double) -> CurrencyObject
    
    @State var selectedFriends: Set<Int> = []
    
    var body: some View {
        VStack {
            Toggle("Apply to All Friends", isOn: $applyToAll)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
            
            if (getSplitGroupCount() > 0) {
                Text("Cost Per Person: \(calculateCostPerPerson(getSplitGroupCount()).priceFormatted)")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
            }
            
            if (!applyToAll) {
                ScrollView {
                    ForEach(friends.indices, id: \.self) { i in
                        HStack {
                            Text("\(getFriendSelectionEmoji(friendIndex: i))  \(friends[i].firstName) \(friends[i].lastName)")
                                .font(.system(size: 20, weight: .semibold))
                                .padding(.leading, 5)
                            
                            Spacer()
                        }
                            .padding()
                            .background(Color(red: friends[i].color.red, green: friends[i].color.green, blue: friends[i].color.blue))
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                            .cornerRadius(10)
                            .onTapGesture {
                                handleFriendSelection(friendIndex: i)
                            }
                    }
                }
            }
            
            SplitModalButtons(
                cancelAction: closeSplitItemModal,
                splitItemAction: handleSplit
            )
        }
            .padding(.horizontal)
    }
    
    func handleFriendSelection(friendIndex: Int) {
        if (selectedFriends.contains(friendIndex)) {
            selectedFriends.remove(friendIndex)
        } else {
            selectedFriends.insert(friendIndex)
        }
    }
    
    func getFriendSelectionEmoji(friendIndex: Int) -> String {
        var friendEmoji: String = "⛔️"
        if (selectedFriends.contains(friendIndex)) {
            friendEmoji = "✅"
        }
        return friendEmoji
    }
    
    func getSplitGroupCount() -> Double {
        var splitGroupCount: Int
        
        if (applyToAll) {
            splitGroupCount = friends.count
        } else {
            splitGroupCount = selectedFriends.count
        }
        
        return Double(splitGroupCount)
    }
    
    func handleSplit() {
        let costPerPerson = calculateCostPerPerson(getSplitGroupCount())
        
        var friendsToSplit: [Int]
        if (applyToAll) {
            friendsToSplit = Array(0..<friends.count)
        } else {
            friendsToSplit = Array(selectedFriends)
        }
        
        for friendIndex in friendsToSplit {
            let newItem = ReciptItem(name: items[itemSplitIndex!].name, price: costPerPerson.price)
            friends[friendIndex].items.append(newItem)
        }
        
        
        items.remove(at: itemSplitIndex!)
        closeSplitItemModal()
    }
}
