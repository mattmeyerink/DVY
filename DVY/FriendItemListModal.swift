//
//  FriendItemList.swift
//  DVY
//
//  Created by Matthew Meyerink on 11/23/21.
//

import SwiftUI

struct FriendItemListModal: View {
    @Binding var friend: Person?
    @Binding var items: [ReciptItem]
    
    @Binding var isFriendItemListOpen: Bool
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    if let f = friend {
                        Text(f.firstName + "'s Items")
                            .font(.system(size: 35, weight: .semibold))
                            .foregroundColor(Color.white)
                    } else {
                        Text("Friend's Items")
                            .font(.system(size: 35, weight: .semibold))
                            .foregroundColor(Color.white)
                    }
                    
                    
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 35, weight: .semibold))
                        .onTapGesture() {
                            self.isFriendItemListOpen = false
                        }
                }
                    .padding(.vertical, 20)
            }
        }
            .frame(width: 350, height: 300, alignment: .center)
            .padding(.bottom, 30)
            .background(Color(red: 0.1, green: 0.1, blue: 0.1))
            .cornerRadius(15)
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
            .onDisappear {
                UITableView.appearance().backgroundColor = .systemGroupedBackground
            }
    }
}
