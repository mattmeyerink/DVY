//
//  FriendsList.swift
//  DVY
//
//  Created by Matthew Meyerink on 11/21/21.
//

import SwiftUI

struct FriendsList: View {
    @Binding var friends: [Person]
    @Binding var isFriendsListOpen: Bool
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Who Got It?")
                        .font(.system(size: 35, weight: .semibold))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 35, weight: .semibold))
                        .onTapGesture() {
                            self.isFriendsListOpen = false
                        }
                }
                    .padding(.vertical, 20)
                
                ScrollView {
                    ForEach($friends.indices, id: \.self) { i in
                        VStack {
                            HStack {
                                Text(friends[i].firstName + " " + friends[i].lastName)
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.leading, 5)
                                
                                Spacer()
                                
                                Text(String(friends[i].items.count) + " Item(s)")
                            }
                        }
                            .padding()
                            .background(Color(red: friends[i].color.red, green: friends[i].color.green, blue: friends[i].color.blue))
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                            .cornerRadius(10)
                    }
                }
            }
                .padding(.horizontal)
                .frame(width: 350, height: 350, alignment: .center)
                .padding(.bottom, 30)
                .background(Color(red: 0.1, green: 0.1, blue: 0.1)).cornerRadius(15)
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                    UITableView.appearance().backgroundColor = .systemGroupedBackground
                }
        }
    }
}
