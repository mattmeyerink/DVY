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
    @State var friendColor: Color
    
    @State var deletePreviouslyAddedFriend: (Person) -> Void
    @State var addPreviouslyAddedFriend: (Person) -> Void
    
    @State var modalTitle: String = "Add Friend"
    @State var otherModalOpening: Bool = false
    
    static let stackDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy"
        return formatter
    }()
    
    var body: some View {
        Modal(
            modalTitle: $modalTitle,
            otherModalOpening: $otherModalOpening,
            closeModal: closeModal,
            modalHeight: 450
        ) {
            VStack {
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
                
                ColorPicker("Friend Color", selection: $friendColor, supportsOpacity: false)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(Color.white)
                    .cornerRadius(10)
                
                
                HStack {
                    Button(action: { deletePreviouslyAddedFriend(currentFriend) } ) {
                        Text("Delete")
                    }
                        .buttonStyle(RedButton())
                    
                    Spacer()
                    
                    Button(action: addPreviousFriendHandler) {
                        Text("Add Friend")
                    }
                        .buttonStyle(GreenButton())
                }
                    .padding(.top)
            }
                .padding(.horizontal)
        }
    }
    
    func addPreviousFriendHandler() {
        let colorComponents = UIColor(friendColor).cgColor.components!
        let formattedColor = DVYColor(red: colorComponents[0], green: colorComponents[1], blue: colorComponents[2])
        currentFriend.color = formattedColor
        addPreviouslyAddedFriend(currentFriend)
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
    
    func closeModal() -> Void {
        isPreviouslyAddedFriendsOpen = false
    }
}
