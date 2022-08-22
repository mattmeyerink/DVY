//
//  FriendsList.swift
//  DVY
//
//  Created by Matthew Meyerink on 11/21/21.
//

import SwiftUI

struct FriendsListModal: View {
    @Binding var friends: [Person]
    @Binding var items: [ReciptItem]
    @Binding var isFriendsListOpen: Bool
    @Binding var itemBeingAssignedIndex: Int?
    @Binding var itemSplitIndex: Int?
    @Binding var isSplitItemModalOpen: Bool
    
    @State var openDeleteConfirmationModal: () -> Void
    
    @State var modalTitle: String = "Who Got It 🤨"
    @State var otherModalOpening: Bool = false
    
    var body: some View {
        Modal(
            modalTitle: $modalTitle,
            otherModalOpening: $otherModalOpening,
            closeModal: closeFriendsListModal,
            modalHeight: 450
        ) {
            VStack {
                ScrollView {
                    ForEach($friends.indices, id: \.self) { i in
                        VStack {
                            HStack {
                                Text(friends[i].firstName + " " + friends[i].lastName)
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.leading, 5)
                                
                                Spacer()
                                
                                Text(getFriendItemText(friendIndex: i))
                            }
                        }
                            .padding()
                            .background(Color(red: friends[i].color.red, green: friends[i].color.green, blue: friends[i].color.blue))
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                            .cornerRadius(10)
                            .onTapGesture {
                                assignItem(friendIndex: i)
                            }
                    }
                }
                
                HStack {
                    Image(systemName: "trash.fill")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top,  10)
                        .padding(.horizontal, 10)
                        .onTapGesture() {
                            openDeleteConfirmationModal()
                        }

                    Image(systemName: "divide.circle.fill")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top,  10)
                        .padding(.horizontal, 10)
                        .onTapGesture() {
                            openSplitItemModal()
                        }
                }
            }
                .padding()
        }
    }
    
    func assignItem(friendIndex: Int) {
        friends[friendIndex].items.append(items[itemBeingAssignedIndex!])
        items.remove(at: itemBeingAssignedIndex!)
        itemBeingAssignedIndex = nil
        isFriendsListOpen = false
    }
    
    func openSplitItemModal() {
        isFriendsListOpen = false
        isSplitItemModalOpen = true
        itemSplitIndex = itemBeingAssignedIndex
        itemBeingAssignedIndex = nil
    }
    
    func closeFriendsListModal() {
        isFriendsListOpen = false
    }
    
    func getFriendItemText(friendIndex: Int) -> String {
        let friendItems = friends[friendIndex].items.count
        var output = String(friendItems) + " Item"
        
        if (friendItems != 1) {
            output += "s"
        }
        
        return output
    }
}
