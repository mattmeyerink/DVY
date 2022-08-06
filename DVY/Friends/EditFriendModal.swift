//
//  EditFriendModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/23/21.
//
import SwiftUI

struct EditFriendModal: View {
    @Binding var friends: [Person]
    @Binding var modalTitle: String
    @Binding var previouslyAddedFriends: [Person]
    @Binding var editFriendContactId: UUID?
    
    @State var firstName: String
    @State var lastName: String
    @State var friendColor: Color
    @State var editFriendIndex: Int?
    @State var otherModalOpening: Bool = false
    
    let saveAction: ([Person]) -> Void
    let closeEditFriendModal: () -> Void
    
    var body: some View {
        Modal(
            modalTitle: $modalTitle,
            otherModalOpening: $otherModalOpening,
            closeModal: closeEditFriendModal,
            modalHeight: 550
        ) {
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
                    Button(action: closeEditFriendModal) {
                        Text("Cancel")
                    }
                        .buttonStyle(RedButton())
                    
                    Spacer()
                    
                    Button(action: saveFriend) {
                        Text("Save")
                    }
                        .buttonStyle(GreenButton())
                }
                    .listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))
            }
        }
    }
    
    func saveFriend() {
        if (firstName == "") {
            return
        }
        
        let previouslyAddedFriendsIds = Set(previouslyAddedFriends.map { $0.id })
        
        let colorComponents = UIColor(friendColor).cgColor.components!
        let formattedColor = DVYColor(red: colorComponents[0], green: colorComponents[1], blue: colorComponents[2])
        
        if (editFriendIndex != nil) {
            friends[editFriendIndex!].firstName = firstName
            friends[editFriendIndex!].lastName = lastName
            friends[editFriendIndex!].setInitials()
            friends[editFriendIndex!].color = formattedColor
            
            if (previouslyAddedFriendsIds.contains(friends[editFriendIndex!].id)) {
                let previouslyAddedFriendIndex = previouslyAddedFriends.firstIndex(where: { $0.id == friends[editFriendIndex!].id })
                previouslyAddedFriends[previouslyAddedFriendIndex!].firstName = firstName
                previouslyAddedFriends[previouslyAddedFriendIndex!].lastName = lastName
                previouslyAddedFriends[previouslyAddedFriendIndex!].setInitials()
                previouslyAddedFriends[previouslyAddedFriendIndex!].color = formattedColor
            }
        } else {
            var newFriend = Person(firstName: firstName, lastName: lastName, color: formattedColor)
            newFriend.contactId = editFriendContactId
            friends.append(newFriend)
        }
        
        
        saveAction(previouslyAddedFriends + friends.filter { !previouslyAddedFriendsIds.contains($0.id) })
        editFriendContactId = nil
        closeEditFriendModal()
    }
}
