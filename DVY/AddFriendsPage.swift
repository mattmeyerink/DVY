//
//  AddFriends.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/16/21.
//

import SwiftUI

struct AddFriendsPage: View {
    var friends: [Person] = [
        Person(firstName: "Matthew", lastName: "Meyerink", color: 0),
        Person(firstName: "Erika", lastName: "Yasuda", color: 1),
        Person(firstName: "Madison", lastName: "Hegedus", color: 2),
        Person(firstName: "Jason", lastName: "Ting", color: 3),
        Person(firstName: "Kyle", lastName: "Patmore", color: 4)
    ]
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State var isAddFriendOpen: Bool = false
    
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
                            Button(action: {self.isAddFriendOpen = true}) {
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
        }
    }
}

struct AddFriends_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendsPage()
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
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
