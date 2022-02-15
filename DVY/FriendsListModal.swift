//
//  FriendsList.swift
//  DVY
//
//  Created by Matthew Meyerink on 11/21/21.
//

import SwiftUI

struct FriendsListModal: View {
    @Binding var friends: [Person]
    @Binding var items: [ReciptItem]
    @Binding var isFriendsListOpen: Bool
    @Binding var itemBeingAssignedIndex: Int?
    
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
                            .onTapGesture {
                                assignItem(friendIndex: i)
                            }
                    }
                }
                
                HStack {
                    Image(systemName: "trash.fill")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top,  10)
                        .padding(.horizontal, 10)
                        .onTapGesture() {
                            deleteItem()
                        }

                    Image(systemName: "divide.circle.fill")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top,  10)
                        .padding(.horizontal, 10)
                        .onTapGesture() {
                            splitItem()
                        }
                }
            }
                .padding(.horizontal)
                .frame(width: 350, height: 375, alignment: .center)
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
    
    func assignItem(friendIndex: Int) {
        self.friends[friendIndex].items.append(items[self.itemBeingAssignedIndex!])
        self.items.remove(at: self.itemBeingAssignedIndex!)
        self.itemBeingAssignedIndex = nil
        self.isFriendsListOpen = false
    }
    
    func deleteItem() {
        self.isFriendsListOpen = false
        items.remove(at: itemBeingAssignedIndex!)
    }
    
    func splitItem() {
        self.isFriendsListOpen = false
        items[itemBeingAssignedIndex!].price = items[itemBeingAssignedIndex!].price / 2
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        items[itemBeingAssignedIndex!].priceFormatted = formatter.string(from: NSNumber(value: items[itemBeingAssignedIndex!].price)) ?? "$0"
        
        let newItem = ReciptItem(name: items[itemBeingAssignedIndex!].name, price: items[itemBeingAssignedIndex!].price)
        items.insert(newItem, at: itemBeingAssignedIndex!)
    }
}
