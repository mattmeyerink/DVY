//
//  AddedFriendsList.swift
//  DVY
//
//  Created by Matthew Meyerink on 7/31/22.
//

import SwiftUI

struct AddedFriendsList: View {
    @Binding var friends: [Person]
    
    @State var openActionPopup: (Int) -> Void
    @State var addFriend: () -> Void
    
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        Text("Add Friends 🍾")
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
                                openActionPopup(i)
                            }
                        
                        Text(friends[i].firstName)
                            .foregroundColor(Color.white)
                    }
                    
                }
                
                VStack {
                    Button(action: addFriend) {
                        Image(systemName: "plus")
                    }
                        .buttonStyle(AddFriendButton())
                    
                    Text("New Friend")
                        .foregroundColor(Color.white)
                }
            }
        }
    }
}
