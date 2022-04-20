//
//  PreviouslyAddedFriendModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 4/18/22.
//

import SwiftUI

struct PreviouslyAddedFriendModal: View {
    @Binding var isPreviouslyAddedFriendsOpen: Bool
    
    @State var currentFriend: Person
    
    static let stackDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy"
        return formatter
    }()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("Add Friend")
                        .font(.system(size: 35, weight: .semibold))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 35, weight: .semibold))
                        .onTapGesture() {
                            self.isPreviouslyAddedFriendsOpen = false
                        }
                }
                    .padding(.vertical, 20)
                
                HStack {
                    Text("First Name: " + currentFriend.firstName)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                    .padding(.vertical, 5)
                
                HStack {
                    Text("Last Name: " + formatNull(word: currentFriend.lastName))
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                    .padding(.vertical, 5)
                
                HStack {
                    Text("Last Used Date: \(currentFriend.lastUseDate, formatter: Self.stackDateFormat)")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                    .padding(.vertical, 5)
                
                HStack {
                    Text("Used " + String(currentFriend.useCount) + getPlural(word: " Time", amount: currentFriend.useCount))
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                    .padding(.top, 5)
                    .padding(.bottom, 20)
                
                
                HStack {
                    Button(action: {} ) {
                        Text("Delete")
                    }
                        .buttonStyle(RedButton())
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Add Friend")
                    }
                        .buttonStyle(GreenButton())
                }
            }
                .padding(.horizontal)
                .frame(width: 350, height: 325, alignment: .center)
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
    
    func getPlural(word: String, amount: Int) -> String {
        var result = word
        
        if (amount > 1) {
            result += "s"
        }
        
        return result
    }
    
    func formatNull(word: String) -> String {
        var result = word
        
        if (word.isEmpty) {
            result = "N/A"
        }
        
        return result
    }
}
