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
            ForEach(previouslyAddedFriends.indices, id: \.self) { i in
                if (isFriendVisible(friend: previouslyAddedFriends[i])) {
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
                            openPreviouslySelectedFriendModal(previouslyAddedFriends[i])
                        }
                }
            }
        }
    }
    
    func updateFilteredFriendList(newSearchTerm: String) -> Void {
        filteredPreviouslyAddedFriends = previouslyAddedFriends.filter { personMatchesSearchTerm(searchTerm: newSearchTerm, friend: $0) }
    }
    
    func personMatchesSearchTerm(searchTerm: String, friend: Person) -> Bool {
        let friendNameFormatted = (friend.firstName + friend.lastName).lowercased().replacingOccurrences(of: " ", with: "")
        let searchTermFormatted = searchTerm.lowercased().replacingOccurrences(of: " ", with: "")
        return friendNameFormatted.contains(searchTermFormatted)
    }
    
    func isFriendVisible(friend: Person) -> Bool {
        let friendAlreadyAdded = Set(friends.map { $0.id }).contains(friend.id)
        let friendFitsSearchText = Set(filteredPreviouslyAddedFriends.map { $0.id }).contains(friend.id)
        return !friendAlreadyAdded && (searchText == "" || friendFitsSearchText)
    }
}
