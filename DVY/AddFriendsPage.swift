//
//  AddFriends.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/16/21.
//

import SwiftUI

struct AddFriendsPage: View {
    @Binding var currentPage: String
    @Binding var friends: [Person]
    
    @State var isAddFriendOpen: Bool = false
    @State var editFriendFirstName: String = ""
    @State var editFriendLastName: String = ""
    
    @State var isActionPopupOpen: Bool = false
    @State var actionFriendIndex: Int?
    
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text("Add Friends")
                    .font(.system(size: 30, weight: .semibold))
            
                    .padding(.vertical, 15)
                    .foregroundColor(Color.white)
                
                ScrollView {
                    LazyVGrid(columns: gridItemLayout, spacing: 20) {
                        ForEach(friends.indices, id: \.self) { i in
                            VStack{
                                ZStack {
                                    Circle()
                                        .fill(Color(red: friends[i].color.red, green: friends[i].color.green, blue: friends[i].color.blue))
                                        .frame(width: 85, height: 85)
                                    
                                    Text(friends[i].initials)
                                        .font(.system(size: 40, weight: .semibold))
                                        .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                                }
                                    .onTapGesture() {
                                        openActionPopup(actionFriendIndex: i)
                                    }
                                
                                Text(friends[i].firstName)
                                    .foregroundColor(Color.white)
                            }
                            
                        }
                        
                        VStack {
                            Button(action: {addFriend()}) {
                                Image(systemName: "plus")
                            }
                                .buttonStyle(AddFriendButton())
                            
                            Text("New Friend")
                                .foregroundColor(Color.white)
                        }
                    }
                }
            }
                .padding(.horizontal)
            
            if (isActionPopupOpen) {
                FriendActionModal(
                    isFriendActionOpen: $isActionPopupOpen,
                    friends: $friends,
                    isEditFriendOpen: $isAddFriendOpen,
                    editFriendFirstName: $editFriendFirstName,
                    editFriendLastName: $editFriendLastName,
                    actionFriendIndex: $actionFriendIndex
                    
                )
            }
            
            if (isAddFriendOpen) {
                EditFriendModal(
                    friends: $friends,
                    isEditFriendOpen: $isAddFriendOpen,
                    firstName: editFriendFirstName,
                    lastName: editFriendLastName,
                    editFriendIndex: actionFriendIndex
                )
            }
        }
        .navigationBarItems(
            leading: Button(action: {self.currentPage = "scanConfirmationPage"}) {
                Text("< Back").foregroundColor(Color.white)
            },
            trailing: Button(action: {self.currentPage = "taxTipPage"}) {
                Text("Next >").foregroundColor(Color.white)
            }
        )
    }
    
    func addFriend() {
        self.editFriendFirstName = ""
        self.editFriendLastName = ""
        self.actionFriendIndex = nil
        self.isAddFriendOpen = true
    }
    
    func openActionPopup(actionFriendIndex: Int) {
        self.actionFriendIndex = actionFriendIndex
        self.isActionPopupOpen = true
    }
}

struct AddFriendButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 40, weight: .semibold))
            .padding(21.75)
            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
            .background(Color(red: 0.2, green: 0.9, blue: 0.25))
            .clipShape(Circle())
            .frame(width: 85, height: 85)
            .scaleEffect(configuration.isPressed ? 0.85 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
