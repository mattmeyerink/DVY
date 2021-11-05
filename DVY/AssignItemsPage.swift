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
                                Text(friends[i].initials)
                                    .font(.system(size: 40, weight: .semibold))
                                    .padding(20)
                                    .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                                    .background(Color(red: friends[i].color.red, green: friends[i].color.green, blue: friends[i].color.blue))
                                    .clipShape(Circle())
                                
                                Text(friends[i].firstName)
                                    .foregroundColor(Color.white)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                    .padding(.horizontal)
                    .padding(.bottom)
                
                VStack {
                    ForEach(items.indices, id: \.self) { i in
                        DragableRecieptItem(item: items[i])
                    }
                }
                    .padding(.horizontal)
            }
        }
        .navigationBarItems(
            leading: Button(action: {self.currentPage = "addFriendsPage"}) {
                Text("< Back").foregroundColor(Color.white)
            }
        )
    }
}
