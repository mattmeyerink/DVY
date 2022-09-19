//
//  AssignItemsPage.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/31/21.
//

import SwiftUI

struct AssignItemsPage: View {
    @Binding var currentPage: Pages
    @Binding var friends: [Person]
    @Binding var items: [ReciptItem]
    
    @State var isFriendsListOpen: Bool = false
    @State var itemBeingAssignedIndex: Int? = nil
    
    @State var isFriendItemListOpen: Bool = false
    @State var friendListOpenFriendIndex: Int? = nil
    @State var friendsItemListModalTitle: String = ""
    
    @State var isSplitItemModalOpen: Bool = false
    @State var itemSplitIndex: Int? = nil
    
    @State var isDeleteConfirmationOpen: Bool = false
    @State var deleteConfirmationText: String = ""
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text("Tap to Assign 🌯")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(Color.white)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(friends.indices, id: \.self) { i in
                            VStack {
                                if (friends[i].items.count == 0) {
                                    ZStack {
                                        Circle()
                                            .fill(Color(red: friends[i].color.red, green: friends[i].color.green, blue: friends[i].color.blue))
                                            .frame(width: 85, height: 85)
                                        
                                        Text(friends[i].initials)
                                            .font(.system(size: 40, weight: .semibold))
                                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                                    }
                                } else {
                                    ZStack {
                                        Circle()
                                            .fill(Color(red: friends[i].color.red, green: friends[i].color.green, blue: friends[i].color.blue))
                                            .frame(width: 85, height: 85)
                                        
                                        Text(String(friends[i].items.count))
                                            .font(.system(size: 40, weight: .semibold))
                                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                                    }
                                        .onTapGesture {
                                            openFriendItemList(friendIndex: i)
                                        }
                                }
                                
                                Text(friends[i].firstName)
                                    .foregroundColor(Color.white)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                    .padding(.horizontal)
                    .padding(.bottom)
                
                ScrollView {
                    if (items.count != 0) {
                        ForEach(items.indices, id: \.self) { i in
                            RecieptItem(item: items[i])
                                .onTapGesture {
                                    openFriendsList(itemIndex: i)
                                }
                        }
                    } else {
                        EmptyMessage(
                            firstLine: "No Items to Assign.",
                            secondLine: "Onward To The Summary!",
                            emojis: "👉"
                        )
                    }
                }
                    .padding(.horizontal)
            }
            
            if (isFriendsListOpen) {
                FriendsListModal(
                    friends: $friends,
                    items: $items,
                    isFriendsListOpen: $isFriendsListOpen,
                    itemBeingAssignedIndex: $itemBeingAssignedIndex,
                    itemSplitIndex: $itemSplitIndex,
                    isSplitItemModalOpen: $isSplitItemModalOpen,
                    openDeleteConfirmationModal: openDeleteConfirmationModal
                )
            }
            
            if (isFriendItemListOpen) {
                FriendItemListModal(
                    friendIndex: $friendListOpenFriendIndex,
                    friends: $friends,
                    items: $items,
                    isFriendItemListOpen: $isFriendItemListOpen,
                    modalTitle: $friendsItemListModalTitle
                )
            }
            
            if (isSplitItemModalOpen) {
                SplitItemModal(
                    currentPage: $currentPage,
                    isSplitItemModalOpen: $isSplitItemModalOpen,
                    items: $items,
                    friends: $friends,
                    itemSplitIndex: $itemSplitIndex,
                    itemExpanded: $itemBeingAssignedIndex,
                    splitAssignmentType: 1
                )
            }
            
            if (isDeleteConfirmationOpen) {
                DeleteConfirmationModal(
                    otherModalOpening: isDeleteConfirmationOpen,
                    modalHeight: 300,
                    message: deleteConfirmationText,
                    deleteButtonText: "Delete",
                    closeModal: closeDeleteConfirmationModal,
                    delete: deleteItem
                )
            }
        }
        .navigationBarItems(
            leading: Button(action: { currentPage = .addFriendsPage }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 15, weight: .bold))
                    
                    Text("Back")
                        .fontWeight(.bold)
                }
                    .foregroundColor(.white)
            },
            trailing: Button(action: navigateToSummaryPage) {
                if (items.count == 0) {
                    HStack {
                        Text("Next")
                            .fontWeight(.bold)
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 15, weight: .bold))
                    }
                        .foregroundColor(.white)
                } else {
                    Text("Assign All Items")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
            }
        )
    }
    
    func openFriendsList(itemIndex: Int) {
        isFriendItemListOpen = false
        friendListOpenFriendIndex = nil
        
        itemBeingAssignedIndex = itemIndex
        isFriendsListOpen = true
    }
    
    func openFriendItemList(friendIndex: Int) {
        isFriendsListOpen = false
        itemBeingAssignedIndex = nil
        
        isFriendItemListOpen = true
        friendListOpenFriendIndex = friendIndex
        friendsItemListModalTitle = friends[friendIndex].firstName + "'s Items 🥞"
    }
    
    func navigateToSummaryPage() {
        if (self.items.count == 0) {
            self.currentPage = .summaryPage
        }
    }
    
    func openDeleteConfirmationModal() -> Void {
        deleteConfirmationText = generateDeleteConfirmationText()
        isFriendsListOpen = false
        isDeleteConfirmationOpen = true
    }
    
    func closeDeleteConfirmationModal() -> Void {
        isDeleteConfirmationOpen = false
        deleteConfirmationText = ""
    }
    
    func generateDeleteConfirmationText() -> String {
        let itemName = items[itemBeingAssignedIndex!].name
        return "Are you sure you want to delete '" + itemName + "'? This action can't be undone!"
    }
    
    func deleteItem() {
        items.remove(at: itemBeingAssignedIndex!)
        closeDeleteConfirmationModal()
    }
}
