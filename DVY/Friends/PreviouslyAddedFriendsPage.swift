//
//  PreviouslyAddedFriendsPage.swift
//  DVY
//
//  Created by Matthew Meyerink on 7/30/22.
//

import SwiftUI

struct PreviouslyAddedFriendsPage: View {
    @Binding var friends: [Person]
    @Binding var previouslyAddedFriends: [Person]
    @Binding var isPreviouslyAddedFriendsOpen: Bool
    
    @State var openPreviouslySelectedFriendModal: (Person) -> Void
    @State var searchText: String = ""
    @State var filteredPreviouslyAddedFriends: [Person] = []
    
    var body: some View {
        Text("Previous Friends")
            .font(.system(size: 30, weight: .semibold))
            .padding(.vertical, 15)
            .foregroundColor(Color.white)
        
        TextField("Search...", text: $searchText)
            .textFieldStyle(.roundedBorder)
            .padding()
            .onChange(of: searchText, perform: updateFilteredFriendList)
        
        ScrollView {
            if (oneOrMoreFriendsVisible()) {
                ForEach(filteredPreviouslyAddedFriends.indices, id: \.self) { i in
                    if (filteredPreviouslyAddedFriends[i].isVisible!) {
                        VStack {
                            HStack {
                                Text(filteredPreviouslyAddedFriends[i].firstName + " " + filteredPreviouslyAddedFriends[i].lastName)
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.leading, 5)
                                
                                Spacer()
                            }
                        }
                            .padding()
                            .background(
                                Color(
                                    red: filteredPreviouslyAddedFriends[i].color.red,
                                    green: filteredPreviouslyAddedFriends[i].color.green,
                                    blue: filteredPreviouslyAddedFriends[i].color.blue
                                )
                            )
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                            .cornerRadius(10)
                            .onTapGesture {
                                handlePreviouslyAddedFriendTap(friendIndex: i)
                            }
                    }
                }
            } else if (searchText != "") {
                EmptyMessage(
                    firstLine: "No Friends Match the Search.",
                    secondLine: "Try a Different Search Term!",
                    emojis: "🔎"
                )
            } else {
                EmptyMessage(
                    firstLine: "No Previously Added Friends.",
                    secondLine: "Add Some Friends and Come Back to See Them!",
                    emojis: "✌️"
                )
            }
        }
        .onAppear {
            filteredPreviouslyAddedFriends = previouslyAddedFriends
        }
        .onChange(of: isPreviouslyAddedFriendsOpen) { newModalOpenValue in
            if (!newModalOpenValue) {
                updateFilteredFriendList(newSearchTerm: searchText)
            }
        }
    }
    
    func handlePreviouslyAddedFriendTap(friendIndex: Int) -> Void {
        hideKeyboard()
        openPreviouslySelectedFriendModal(filteredPreviouslyAddedFriends[friendIndex])
    }
    
    func updateFilteredFriendList(newSearchTerm: String) -> Void {
        if (searchText.replacingOccurrences(of: " ", with: "") == "") {
            filteredPreviouslyAddedFriends = previouslyAddedFriends
        } else {
            filteredPreviouslyAddedFriends = previouslyAddedFriends.filter { personMatchesSearchTerm(searchTerm: newSearchTerm, friend: $0) }
        }
    }
    
    func personMatchesSearchTerm(searchTerm: String, friend: Person) -> Bool {
        let friendNameFormatted = (friend.firstName + friend.lastName).lowercased().replacingOccurrences(of: " ", with: "")
        let searchTermFormatted = searchTerm.lowercased().replacingOccurrences(of: " ", with: "")
        return friendNameFormatted.contains(searchTermFormatted)
    }
    
    func oneOrMoreFriendsVisible() -> Bool {
        var output = false
        for friend in filteredPreviouslyAddedFriends {
            if (friend.isVisible!) {
                output = true
                break
            }
        }
        return output
    }
}
