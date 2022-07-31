//
//  AddFriends.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/16/21.
//

import SwiftUI

struct AddFriendsPage: View {
    @Binding var currentPage: Pages
    @Binding var friends: [Person]
    
    @State var isAddFriendOpen: Bool = false
    @State var editModalTitle: String = ""
    @State var editFriendFirstName: String = ""
    @State var editFriendLastName: String = ""
    @State var editFriendColor: Color = Color.blue
    
    @State var isActionPopupOpen: Bool = false
    @State var actionFriendIndex: Int?
    
    @State var isPreviouslyAddedFriendsOpen: Bool = false
    @State var currentPreviousFriend: Person?
    @State var previouslyAddedFriendColor: Color = Color.blue
    
    @State var previouslyAddedFriends: [Person]
    @State var saveFriendAction: ([Person]) -> Void
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                AddedFriendsList(
                    friends: $friends,
                    openActionPopup: openActionPopup,
                    addFriend: addFriend
                )
                
                if (getArePreviouslyAddedFriendsVisible()) {
                    PreviouslyAddedFriendsPage(
                        friends: $friends,
                        previouslyAddedFriends: $previouslyAddedFriends,
                        openPreviouslySelectedFriendModal: openPreviouslySelectedFriendModal
                    )
                }
            }
                .padding(.horizontal)
            
            if (isActionPopupOpen) {
                FriendActionModal(
                    isFriendActionOpen: $isActionPopupOpen,
                    isEditFriendOpen: $isAddFriendOpen,
                    actionFriendIndex: $actionFriendIndex,
                    deleteFriend: deleteFriend,
                    editFriend: editFriend
                )
            }
            
            if (isAddFriendOpen) {
                EditFriendModal(
                    friends: $friends,
                    isEditFriendOpen: $isAddFriendOpen,
                    modalTitle: $editModalTitle,
                    firstName: editFriendFirstName,
                    lastName: editFriendLastName,
                    friendColor: editFriendColor,
                    editFriendIndex: actionFriendIndex,
                    previouslyAddedFriends: previouslyAddedFriends,
                    saveAction: saveFriendAction
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
        }
        .navigationBarItems(
            leading: Button(action: { currentPage = .taxTipPage }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 15, weight: .bold))
                    
                    Text("Back")
                        .fontWeight(.bold)
                }
                    .foregroundColor(.white)
            },
            trailing: Button(action: routeToAssignItemsPage) {
                if (friends.count > 0) {
                    HStack {
                        Text("Next")
                            .fontWeight(.bold)
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 15, weight: .bold))
                    }
                        .foregroundColor(.white)
                } else {
                    Text("Add Friends to Continue")
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
        
        actionFriendIndex = nil
        isAddFriendOpen = true
    }
    
    func editFriend() {
        let editFriend = friends[actionFriendIndex!]
        editModalTitle = "Edit ✍️"
        editFriendFirstName = editFriend.firstName
        editFriendLastName = editFriend.lastName
        editFriendColor = Color(red: editFriend.color.red, green: editFriend.color.green, blue: editFriend.color.blue)
        actionFriendIndex = nil
        isActionPopupOpen = false
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
        }
        
        friends.remove(at: actionFriendIndex!)
        saveFriendAction(previouslyAddedFriends + friends.filter { !previouslyAddedFriendsIds.contains($0.id) })
        isActionPopupOpen = false
    }
    
    func addPreviouslyAddedFriend(friend: Person) -> Void {
        let prevFriendIndex = previouslyAddedFriends.firstIndex(where: { $0.id == friend.id })
        
        previouslyAddedFriends[prevFriendIndex!].useCount += 1
        previouslyAddedFriends[prevFriendIndex!].previousLastUsedDate = previouslyAddedFriends[prevFriendIndex!].lastUseDate
        previouslyAddedFriends[prevFriendIndex!].lastUseDate = Date()
        previouslyAddedFriends[prevFriendIndex!].color = friend.color
        
        let previouslyAddedFriendsIds = Set(previouslyAddedFriends.map { $0.id })
        saveFriendAction(previouslyAddedFriends + friends.filter { !previouslyAddedFriendsIds.contains($0.id) })
        
        friends.append(previouslyAddedFriends[prevFriendIndex!])
        
        isPreviouslyAddedFriendsOpen = false
    }
    
    func getArePreviouslyAddedFriendsVisible() -> Bool {
        let friendsIds = Set(friends.map { $0.id })
        return previouslyAddedFriends.filter { !friendsIds.contains($0.id) }.count > 0
    }
}

struct AddFriendButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 40, weight: .semibold))
            .padding(21.75)
            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
            .background(Color(red: 0.2, green: 0.9, blue: 0.25))
            .clipShape(Circle())
            .frame(width: 85, height: 85)
            .scaleEffect(configuration.isPressed ? 0.85 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
