//
//  AddFriends.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/16/21.
//

import SwiftUI

struct AddFriendsPage: View {
    @State var friends: [Person] = []
    
    @State var isAddFriendOpen: Bool = false
    @State var editFriendFirstName: String = ""
    @State var editFriendLastName: String = ""
    
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
                        ForEach(friends) { friend in
                            VStack{
                                Text(friend.initials)
                                    .font(.system(size: 40, weight: .semibold))
                                    .padding(20)
                                    .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                                    .background(Color(red: friend.color.red, green: friend.color.green, blue: friend.color.blue))
                                    .clipShape(Circle())
                                
                                Text(friend.firstName)
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
            
            if (isAddFriendOpen) {
                EditFriendModal(
                    friends: $friends,
                    isEditFriendOpen: $isAddFriendOpen,
                    firstName: editFriendFirstName,
                    lastName: editFriendLastName
                )
            }
        }
    }
    
    func addFriend() {
        self.editFriendFirstName = ""
        self.editFriendLastName = ""
        self.isAddFriendOpen = true
    }
}

struct AddFriendButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 40, weight: .semibold))
            .padding(25)
            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
            .background(Color(red: 0.2, green: 0.9, blue: 0.25))
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.85 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
