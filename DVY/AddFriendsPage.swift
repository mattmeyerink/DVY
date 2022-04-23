//
//  AddFriends.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/16/21.
//

import SwiftUI

struct AddFriendsPage: View {
    @Binding var currentPage: String
    @Binding var friends: [Person]
    
    @State var isAddFriendOpen: Bool = false
    @State var editFriendFirstName: String = ""
    @State var editFriendLastName: String = ""
    
    @State var isActionPopupOpen: Bool = false
    @State var actionFriendIndex: Int?
    
    @State var isPreviouslyAddedFriendsOpen: Bool = false
    @State var currentPreviousFriend: Person?
    
    @State var previouslyAddedFriends: [Person]
    @State var saveFriendAction: ([Person]) -> Void
    
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text("Add Friends")
                    .font(.system(size: 30, weight: .semibold))
            
                    .padding(.vertical, 15)
                    .foregroundColor(Color.white)
                
                ScrollView {
                    LazyVGrid(columns: gridItemLayout, spacing: 20) {
                        ForEach(friends.indices, id: \.self) { i in
                            VStack{
                                ZStack {
                                    Circle()
                                        .fill(Color(red: friends[i].color.red, green: friends[i].color.green, blue: friends[i].color.blue))
                                        .frame(width: 85, height: 85)
                                    
                                    Text(friends[i].initials)
                                        .font(.system(size: 40, weight: .semibold))
                                        .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                                }
                                    .onTapGesture() {
                                        openActionPopup(actionFriendIndex: i)
                                    }
                                
                                Text(friends[i].firstName)
                                    .foregroundColor(Color.white)
                            }
                            
                        }
                        
                        VStack {
                            Button(action: {addFriend()}) {
                                Image(systemName: "plus")
                            }
                                .buttonStyle(AddFriendButton())
                            
                            Text("New Friend")
                                .foregroundColor(Color.white)
                        }
                    }
                }
                
                Text("Previous Friends")
                    .font(.system(size: 30, weight: .semibold))
            
                    .padding(.vertical, 15)
                    .foregroundColor(Color.white)
                
                ScrollView {
                    ForEach(previouslyAddedFriends.indices, id: \.self) { i in
                        if (!Set(friends.map { $0.id }).contains(previouslyAddedFriends[i].id)) {
                            VStack {
                                HStack {
                                    Text(previouslyAddedFriends[i].firstName + " " + previouslyAddedFriends[i].lastName)
                                        .font(.system(size: 20, weight: .semibold))
                                        .padding(.leading, 5)
                                    
                                    Spacer()
                                }
                            }
                                .padding()
                                .background(
                                    Color(
                                        red: previouslyAddedFriends[i].color.red,
                                        green: previouslyAddedFriends[i].color.green,
                                        blue: previouslyAddedFriends[i].color.blue
                                    )
                                )
                                .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                                .cornerRadius(10)
                                .onTapGesture {
                                    openPreviouslySelectedFriendModal(currentFriend: previouslyAddedFriends[i])
                                }
                        }
                    }
                }
            }
                .padding(.horizontal)
            
            if (isActionPopupOpen) {
                FriendActionModal(
                    isFriendActionOpen: $isActionPopupOpen,
                    friends: $friends,
                    isEditFriendOpen: $isAddFriendOpen,
                    editFriendFirstName: $editFriendFirstName,
                    editFriendLastName: $editFriendLastName,
                    actionFriendIndex: $actionFriendIndex,
                    deleteFriend: deleteFriend
                )
            }
            
            if (isAddFriendOpen) {
                EditFriendModal(
                    friends: $friends,
                    isEditFriendOpen: $isAddFriendOpen,
                    firstName: editFriendFirstName,
                    lastName: editFriendLastName,
                    editFriendIndex: actionFriendIndex,
                    previouslyAddedFriends: previouslyAddedFriends,
                    saveAction: saveFriendAction
                )
            }
            
            if (isPreviouslyAddedFriendsOpen) {
                PreviouslyAddedFriendModal(
                    isPreviouslyAddedFriendsOpen: $isPreviouslyAddedFriendsOpen,
                    currentFriend: currentPreviousFriend!,
                    deletePreviouslyAddedFriend: deletePreviouslyAddedFriend,
                    addPreviouslyAddedFriend: addPreviouslyAddedFriend
                )
            }
        }
        .navigationBarItems(
            leading: Button(action: {self.currentPage = "taxTipPage"}) {
                Text("< Back")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            },
            trailing: Button(action: { routeToAssignItemsPage() }) {
                if (self.friends.count > 0) {
                    Text("Next >")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                } else {
                    Text("Add Friends to Continue")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
            }
        )
    }
    
    func addFriend() {
        self.editFriendFirstName = ""
        self.editFriendLastName = ""
        self.actionFriendIndex = nil
        self.isAddFriendOpen = true
    }
    
    func openActionPopup(actionFriendIndex: Int) {
        self.actionFriendIndex = actionFriendIndex
        isActionPopupOpen = true
    }
    
    func routeToAssignItemsPage() {
        if (friends.count > 0) {
            currentPage = "assignItemsPage"
        }
    }
    
    func openPreviouslySelectedFriendModal(currentFriend: Person) {
        currentPreviousFriend = currentFriend
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
        
        let previouslyAddedFriendsIds = Set(previouslyAddedFriends.map { $0.id })
        saveFriendAction(previouslyAddedFriends + friends.filter { !previouslyAddedFriendsIds.contains($0.id) })
        
        friends.append(previouslyAddedFriends[prevFriendIndex!])
        
        isPreviouslyAddedFriendsOpen = false
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
