//
//  AddFriends.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/16/21.
//

import SwiftUI

struct AddFriendsPage: View {
    var friends: [Person] = [
        Person(firstName: "Matthew", lastName: "Meyerink"),
        Person(firstName: "Erika", lastName: "Yasuda"),
        Person(firstName: "Madison", lastName: "Hegedus"),
        Person(firstName: "Jason", lastName: "Ting")
    ]
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
                            Text(friend.initials)
                                .font(.system(size: 40))
                                .padding(20)
                                .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                                .background(Color(red: 0.95, green: 0.8, blue: 0.5))
                                .clipShape(Circle())
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
