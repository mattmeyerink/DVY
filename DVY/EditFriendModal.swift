//
//  EditFriendModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/23/21.
//
import SwiftUI

struct EditFriendModal: View {
    @Binding var friends: [Person]
    @Binding var isEditFriendOpen: Bool
    
    @State var firstName: String
    @State var lastName: String
    @State var friendColor: Color
    
    @State var editFriendIndex: Int?
    
    @State var previouslyAddedFriends: [Person]
    
    let saveAction: ([Person]) -> Void
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            Form {
                Section(header: Text("First Name").font(.system(size: 20, weight: .semibold))) {
                    TextField("First Name", text: $firstName)
                        .foregroundColor(.black)
                }
                    .foregroundColor(.white)
                
                Section(header: Text("Last Name").font(.system(size: 20, weight: .semibold))) {
                    TextField("Last Name", text: $lastName)
                        .foregroundColor(.black)
                }
                    .foregroundColor(.white)
                
                Section() {
                    ColorPicker("Friend Color", selection: $friendColor, supportsOpacity: false)
                }
                
                HStack {
                    Button(action: {closePopup()}) {
                        Text("Cancel")
                    }
                        .buttonStyle(GreenButton())
                    
                    Spacer()
                    
                    Button(action: {saveFriend()}) {
                        Text("Save")
                    }
                        .buttonStyle(GreenButton())
                }
                    .listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))
            }
                .frame(width: 350, height: 380, alignment: .center)
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
    
    func saveFriend() {
        if (firstName == "") {
            return
        }
        
        let previouslyAddedFriendsIds = Set(previouslyAddedFriends.map { $0.id })
        
        if (editFriendIndex != nil) {
            friends[editFriendIndex!].firstName = firstName
            friends[editFriendIndex!].lastName = lastName
            friends[editFriendIndex!].setInitials()
            
            if (previouslyAddedFriendsIds.contains(friends[editFriendIndex!].id)) {
                let previouslyAddedFriendIndex = previouslyAddedFriends.firstIndex(where: { $0.id == friends[editFriendIndex!].id })
                previouslyAddedFriends[previouslyAddedFriendIndex!].firstName = firstName
                previouslyAddedFriends[previouslyAddedFriendIndex!].lastName = lastName
                previouslyAddedFriends[previouslyAddedFriendIndex!].setInitials()
            }
        } else {
            let newFriend = Person(firstName: firstName, lastName: lastName, color: friends.count % DVYColors.count)
            friends.append(newFriend)
        }
        
        
        saveAction(previouslyAddedFriends + friends.filter { !previouslyAddedFriendsIds.contains($0.id) })
        closePopup()
    }
    
    func closePopup() {
        self.isEditFriendOpen = false
    }
}
