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
    
    @State var showingDeleteIndex: Int? = nil
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack {
                if let f = friend {
                    HStack {
                        Text(f.firstName + "'s Items")
                            .font(.system(size: 35, weight: .semibold))
                            .foregroundColor(Color.white)
                        
                        
                        Spacer()
                        
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 35, weight: .semibold))
                            .onTapGesture() {
                                self.isFriendItemListOpen = false
                            }
                    }
                        .padding(.vertical, 20)
                    
                    ScrollView {
                        ForEach(f.items.indices, id: \.self) { i in
                            VStack {
                                HStack {
                                    Text(f.items[i].name)
                                        .font(.system(size: 20, weight: .semibold))
                                        .padding(.leading, 5)
                                    
                                    Spacer()
                                    
                                    if (i == self.showingDeleteIndex) {
                                        Image(systemName: "trash.fill")
                                            .font(.system(size: 20, weight: .semibold))
                                            .padding(.horizontal, 5)
                                            .onTapGesture() {
                                                self.deleteItem(itemIndex: i)
                                            }
                                    } else {
                                        Text(f.items[i].priceFormatted)
                                            .font(.system(size: 20, weight: .semibold))
                                            .padding(.horizontal, 5)
                                    }
                                }
                            }
                                .padding()
                                .background(Color(red: 0.95, green: 0.8, blue: 0.5))
                                .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                                .cornerRadius(10)
                                .onTapGesture {
                                    toggleShowingDelete(itemIndex: i)
                                }
                        }
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text("Subtotal: " + self.calculateSubTotal())
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(Color.white)
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
    
    func toggleShowingDelete(itemIndex: Int) {
        if (itemIndex == self.showingDeleteIndex) {
            self.showingDeleteIndex = nil
        } else {
            self.showingDeleteIndex = itemIndex
        }
    }
    
    func deleteItem(itemIndex: Int) {
        if let f = friend {
            self.items.append(f.items[itemIndex])
            self.friend?.items.remove(at: itemIndex)
            
            if f.items.count == 0 {
                self.isFriendItemListOpen = false
            }
        }
    }
    
    func calculateSubTotal() -> String{
        if let f = friend {
            var total = 0.0
            for item in f.items {
                total += item.price
            }
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            return formatter.string(from: NSNumber(value: total)) ?? "$0.00"
        }
        
        return "$0.00"
    }
}
