//
//  AssignItemsPage.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/31/21.
//

import SwiftUI

struct AssignItemsPage: View {
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
                        }
                    }
                }
                
                ScrollView {
                    ForEach(items.indices, id: \.self) { i in
                        VStack {
                            HStack {
                                Text(items[i].name)
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.leading, 5)
                                Spacer()
                                Text(items[i].priceFormatted)
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.trailing, 5)
                            }
                        }
                            .padding()
                            .background(Color(red: 0.95, green: 0.8, blue: 0.5))
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                            .cornerRadius(10)
                    }
                }
            }
        }
        
    }
}
