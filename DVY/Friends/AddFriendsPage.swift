//
//  AddFriends.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/16/21.
//

import SwiftUI

enum AddFriendsView {
    case addedFriendsList
    case previouslyAddedFriendsList
    case contactsList
}

struct AddFriendsPage: View {
    @Binding var currentPage: Pages
    @Binding var friends: [Person]
    @Binding var contacts: [Contact]
    
    @State var currentAddedFriendsView: AddFriendsView = .addedFriendsList
    
    @State var isAddFriendOpen: Bool = false
    @State var editModalTitle: String = ""
    @State var editFriendFirstName: String = ""
    @State var editFriendLastName: String = ""
    @State var editFriendColor: Color = Color.blue
    @State var editFriendContactId: UUID? = nil
    
    @State var isActionPopupOpen: Bool = false
    @State var actionFriendIndex: Int?
    
    @State var isPreviouslyAddedFriendsOpen: Bool = false
    @State var currentPreviousFriend: Person?
    @State var previouslyAddedFriendColor: Color = Color.blue
    
    @State var previouslyAddedFriends: [Person]
    @State var saveFriendAction: ([Person]) -> Void
    
    @State var isDeleteConfirmationOpen: Bool = false
    @State var deleteConfirmationText: String = ""
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                if (currentAddedFriendsView == .addedFriendsList) {
                    AddedFriendsList(
                        friends: $friends,
                        openActionPopup: openActionPopup,
                        addFriend: addFriend,
                        setCurrentAddedFriendView: setCurrentAddedFriendsView
                    )
                }
                
                if (currentAddedFriendsView == .previouslyAddedFriendsList) {
                    PreviouslyAddedFriendsPage(
                        friends: $friends,
                        previouslyAddedFriends: $previouslyAddedFriends,
                        isPreviouslyAddedFriendsOpen: $isPreviouslyAddedFriendsOpen,
                        openPreviouslySelectedFriendModal: openPreviouslySelectedFriendModal
                    )
                }
                
                if (currentAddedFriendsView == .contactsList) {
                    ContactsList(
                        contacts: $contacts,
                        editFriendContactId: $editFriendContactId,
                        addFriendFromContact: addFriendFromContact
                    )
                }
            }
                .padding(.horizontal)
            
            if (isActionPopupOpen) {
                FriendActionModal(
                    isFriendActionOpen: $isActionPopupOpen,
                    isEditFriendOpen: $isAddFriendOpen,
                    actionFriendIndex: $actionFriendIndex,
                    deleteFriend: openDeleteConfirmationModal,
                    editFriend: editFriend
                )
            }
            
            if (isAddFriendOpen) {
                EditFriendModal(
                    friends: $friends,
                    modalTitle: $editModalTitle,
                    previouslyAddedFriends: $previouslyAddedFriends,
                    editFriendContactId: $editFriendContactId,
                    firstName: editFriendFirstName,
                    lastName: editFriendLastName,
                    friendColor: editFriendColor,
                    editFriendIndex: actionFriendIndex,
                    saveAction: saveFriendAction,
                    closeEditFriendModal: closeEditFriendModal
                )
            }
            
            if (isPreviouslyAddedFriendsOpen) {
                PreviouslyAddedFriendModal(
                    isPreviouslyAddedFriendsOpen: $isPreviouslyAddedFriendsOpen,
                    currentFriend: currentPreviousFriend!,
                    friendColor: previouslyAddedFriendColor,
                    deletePreviouslyAddedFriend: deletePreviouslyAddedFriend,
                    addPreviouslyAddedFriend: addPreviouslyAddedFriend
                )
            }
            
            if (isDeleteConfirmationOpen) {
                DeleteConfirmationModal(
                    otherModalOpening: false,
                    modalHeight: 300,
                    message: deleteConfirmationText,
                    deleteButtonText: "Remove",
                    closeModal: closeDeleteConfirmationModal,
                    delete: deleteFriend
                )
            }
        }
        .navigationBarItems(
            leading: Button(action: backNavigationAction) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 15, weight: .bold))
                    
                    Text("Back")
                        .fontWeight(.bold)
                }
                    .foregroundColor(.white)
            },
            trailing: Button(action: routeToAssignItemsPage) {
                if (currentAddedFriendsView == .addedFriendsList && friends.count > 0) {
                    HStack {
                        Text("Next")
                            .fontWeight(.bold)
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 15, weight: .bold))
                    }
                        .foregroundColor(.white)
                } else if (currentAddedFriendsView == .addedFriendsList) {
                    Text("Add Friends")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
        )
    }
    
    func addFriend() {
        editModalTitle = "Add 🎉"
        
        editFriendFirstName = ""
        editFriendLastName = ""
        
        let color = DVYColors.randomElement()!
        editFriendColor = Color(red: color.red, green: color.green, blue: color.blue)
        
        editFriendContactId = nil
        
        actionFriendIndex = nil
        isAddFriendOpen = true
    }
    
    func editFriend() {
        let editFriend = friends[actionFriendIndex!]
        
        editModalTitle = "Edit ✍️"
        
        editFriendFirstName = editFriend.firstName
        editFriendLastName = editFriend.lastName
        
        editFriendColor = Color(red: editFriend.color.red, green: editFriend.color.green, blue: editFriend.color.blue)
        
        editFriendContactId = nil
        
        isActionPopupOpen = false
        isAddFriendOpen = true
    }
    
    func addFriendFromContact(contact: Contact) {
        editModalTitle = "Add 🎉"
        
        editFriendFirstName = contact.firstName
        editFriendLastName = contact.lastName
        
        let color = DVYColors.randomElement()!
        editFriendColor = Color(red: color.red, green: color.green, blue: color.blue)
        
        editFriendContactId = contact.id
        
        actionFriendIndex = nil
        isAddFriendOpen = true
    }
    
    func openActionPopup(actionFriendIndex: Int) {
        self.actionFriendIndex = actionFriendIndex
        isActionPopupOpen = true
    }
    
    func routeToAssignItemsPage() {
        if (friends.count > 0) {
            currentPage = .assignItemsPage
        }
    }
    
    func openPreviouslySelectedFriendModal(currentFriend: Person) {
        currentPreviousFriend = currentFriend
        previouslyAddedFriendColor = Color(
            red: currentFriend.color.red,
            green: currentFriend.color.green,
            blue: currentFriend.color.blue
        )
        isPreviouslyAddedFriendsOpen = true
    }
    
    func deletePreviouslyAddedFriend(friend: Person) -> Void {
        previouslyAddedFriends = previouslyAddedFriends.filter { $0.id != friend.id }
        saveFriendAction(previouslyAddedFriends + friends)
        isPreviouslyAddedFriendsOpen = false
    }
    
    func deleteFriend() -> Void {
        let previouslyAddedFriendsIds = Set(previouslyAddedFriends.map { $0.id })
        if (previouslyAddedFriendsIds.contains(friends[actionFriendIndex!].id)) {
            let prevFriendIndex = previouslyAddedFriends.firstIndex(where: { $0.id == friends[actionFriendIndex!].id })
            
            previouslyAddedFriends[prevFriendIndex!].useCount -= 1
            previouslyAddedFriends[prevFriendIndex!].lastUseDate = previouslyAddedFriends[prevFriendIndex!].previousLastUsedDate!
            previouslyAddedFriends[prevFriendIndex!].isVisible = true
        }
        
        if (friends[actionFriendIndex!].contactId != nil) {
            for i in 0...contacts.count - 1 {
                if (contacts[i].id == friends[actionFriendIndex!].contactId) {
                    contacts[i].currentlyAdded = false
                    break
                }
            }
        }
        
        friends.remove(at: actionFriendIndex!)
        saveFriendAction(previouslyAddedFriends + friends.filter { !previouslyAddedFriendsIds.contains($0.id) })
        closeDeleteConfirmationModal()
    }
    
    func addPreviouslyAddedFriend(friend: Person) -> Void {
        let prevFriendIndex = previouslyAddedFriends.firstIndex(where: { $0.id == friend.id })
        
        previouslyAddedFriends[prevFriendIndex!].useCount += 1
        previouslyAddedFriends[prevFriendIndex!].previousLastUsedDate = previouslyAddedFriends[prevFriendIndex!].lastUseDate
        previouslyAddedFriends[prevFriendIndex!].lastUseDate = Date()
        previouslyAddedFriends[prevFriendIndex!].color = friend.color
        
        let previouslyAddedFriendsIds = Set(previouslyAddedFriends.map { $0.id })
        saveFriendAction(previouslyAddedFriends + friends.filter { !previouslyAddedFriendsIds.contains($0.id) })
        
        previouslyAddedFriends[prevFriendIndex!].isVisible = false
        
        friends.append(previouslyAddedFriends[prevFriendIndex!])
        
        isPreviouslyAddedFriendsOpen = false
    }
    
    func getArePreviouslyAddedFriendsVisible() -> Bool {
        let friendsIds = Set(friends.map { $0.id })
        return previouslyAddedFriends.filter { !friendsIds.contains($0.id) }.count > 0
    }
    
    func setCurrentAddedFriendsView(newAddedFriendsView: AddFriendsView) -> Void {
        currentAddedFriendsView = newAddedFriendsView
    }
    
    func backNavigationAction() -> Void {
        if (currentAddedFriendsView == .addedFriendsList) {
            currentPage = .taxTipPage
        } else {
            currentAddedFriendsView = .addedFriendsList
        }
    }
    
    func closeEditFriendModal() -> Void {
        if (editFriendContactId != nil) {
            for i in 0...contacts.count - 1 {
                if (contacts[i].id == editFriendContactId) {
                    contacts[i].currentlyAdded = false
                    break
                }
            }
            editFriendContactId = nil
        }
        isAddFriendOpen = false
    }
    
    func openDeleteConfirmationModal() -> Void {
        isActionPopupOpen = false
        deleteConfirmationText = generateDeleteConfirmationText(actionFriendIndex: actionFriendIndex!)
        isDeleteConfirmationOpen = true
    }
    
    func closeDeleteConfirmationModal() -> Void {
        isDeleteConfirmationOpen = false
    }
    
    func generateDeleteConfirmationText(actionFriendIndex: Int) -> String {
        var output = "Are you sure you want to remove " + friends[actionFriendIndex].firstName
        if (friends[actionFriendIndex].lastName != "") {
            output += " " + friends[actionFriendIndex].lastName
        }
        output += "?"
        return output
    }
}
