//
//  PreviouslyAddedFriendsPage.swift
//  DVY
//
//  Created by Matthew Meyerink on 7/30/22.
//

import SwiftUI
import Combine

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
            .onReceive(Just(searchText), perform: updateFilteredFriendList)
        
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
                            openPreviouslySelectedFriendModal(previouslyAddedFriends[i])
                        }
                }
            }
        }
    }
    
    func updateFilteredFriendList(newSearchTerm: String) -> Void {
        if (searchText != "") {
            filteredPreviouslyAddedFriends = previouslyAddedFriends.filter { personMatchesSearchTerm(searchTerm: newSearchTerm, friend: $0) }
        } else {
            filteredPreviouslyAddedFriends = previouslyAddedFriends
        }
        
        print(filteredPreviouslyAddedFriends)
    }
    
    func personMatchesSearchTerm(searchTerm: String, friend: Person) -> Bool {
        let friendNameFormatted = (friend.firstName + friend.lastName).lowercased().replacingOccurrences(of: " ", with: "")
        let searchTermFormatted = searchTerm.lowercased().replacingOccurrences(of: " ", with: "")
        return friendNameFormatted.contains(searchTermFormatted)
    }
}
