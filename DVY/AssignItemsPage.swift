//
//  AssignItemsPage.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/31/21.
//

import SwiftUI

struct AssignItemsPage: View {
    @Binding var currentPage: String
    @Binding var friends: [Person]
    @Binding var items: [ReciptItem]
    
    @State var isFriendsListOpen: Bool = false
    @State var itemBeingAssignedIndex: Int? = nil
    
    @State var isFriendItemListOpen: Bool = false
    @State var friendListOpenFriend: Person? = nil
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text("Assign Items")
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
                    ForEach(items.indices, id: \.self) { i in
                        RecieptItem(item: items[i])
                            .onTapGesture {
                                openFriendsList(itemIndex: i)
                            }
                    }
                }
                    .padding(.horizontal)
            }
            
            if (isFriendsListOpen) {
                FriendsListModal(
                    friends: $friends,
                    items: $items,
                    isFriendsListOpen: $isFriendsListOpen,
                    itemBeingAssignedIndex: $itemBeingAssignedIndex
                )
            }
            
            if (isFriendItemListOpen) {
                FriendItemListModal(
                    friend: $friendListOpenFriend,
                    items: $items,
                    isFriendItemListOpen: $isFriendItemListOpen
                )
            }
        }
        .navigationBarItems(
            leading: Button(action: { self.currentPage = "addFriendsPage" }) {
                Text("< Back").foregroundColor(Color.white)
            },
            trailing: Button(action: { self.currentPage = "taxTipPage"}) {
                Text("Next >").foregroundColor(Color.white)
            }
        )
    }
    
    func openFriendsList(itemIndex: Int) {
        self.isFriendItemListOpen = false
        self.friendListOpenFriend = nil
        
        self.itemBeingAssignedIndex = itemIndex
        self.isFriendsListOpen = true
    }
    
    func openFriendItemList(friendIndex: Int) {
        self.isFriendsListOpen = false
        self.itemBeingAssignedIndex = nil
        
        self.isFriendItemListOpen = true
        self.friendListOpenFriend = friends[friendIndex]
    }
}
