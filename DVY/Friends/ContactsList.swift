//
//  ContactsList.swift
//  DVY
//
//  Created by Matthew Meyerink on 8/3/22.
//

import SwiftUI

struct ContactsList: View {
    @Binding var contacts: [Contact]
    @Binding var editFriendContactId: UUID?
    @Binding var contactsAccessDenied: Bool
    
    @State var addFriendFromContact: (Contact) -> Void
    
    @State var searchText: String = ""
    @State var filteredContacts: [Contact] = []
    
    var body: some View {
        Text("Contacts 📖")
            .font(.system(size: 30, weight: .semibold))
            .padding(.vertical, 15)
            .foregroundColor(Color.white)
        
        TextField("Search...", text: $searchText)
            .textFieldStyle(.roundedBorder)
            .padding()
            .onChange(of: searchText, perform: updateFilteredContactsList)
        
        ScrollView {
            if (isFilteredContactVisible()) {
                ForEach(filteredContacts.indices, id: \.self) { i in
                    if (!filteredContacts[i].currentlyAdded) {
                        VStack {
                            HStack {
                                Text(filteredContacts[i].firstName + " " + filteredContacts[i].lastName)
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.leading, 5)
                                
                                Spacer()
                            }
                        }
                            .padding()
                            .background(Color(red: 0.95, green: 0.8, blue: 0.5))
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                            .cornerRadius(10)
                            .onTapGesture {
                                handleContactTap(filteredContactIndex: i)
                            }
                    }
                }
            } else if (contactsAccessDenied) {
                VStack {
                    Text("Error Getting Contacts.")
                        .font(.system(size: 25, weight: .semibold))
                        .padding(.vertical, 15)
                        .foregroundColor(Color.white)
                    
                    Text("Make Sure DVY Has Access!")
                        .font(.system(size: 25, weight: .semibold))
                        .padding(.vertical, 5)
                        .foregroundColor(Color.white)
                    
                    Text("👀")
                        .font(.system(size: 35))
                        .padding(.vertical, 5)
                }
            } else if (searchText != "") {
                VStack {
                    Text("No Contacts Match the Search.")
                        .font(.system(size: 25, weight: .semibold))
                        .padding(.vertical, 15)
                        .foregroundColor(Color.white)
                    
                    Text("Try a Different Search Term!")
                        .font(.system(size: 25, weight: .semibold))
                        .padding(.vertical, 5)
                        .foregroundColor(Color.white)
                    
                    Text("🔎")
                        .font(.system(size: 35))
                        .padding(.vertical, 5)
                }
            } else {
                VStack {
                    Text("No Contacts Found.")
                        .font(.system(size: 25, weight: .semibold))
                        .padding(.vertical, 15)
                        .foregroundColor(Color.white)
                    
                    Text("Go Out and Meet Some People!")
                        .font(.system(size: 25, weight: .semibold))
                        .padding(.vertical, 5)
                        .foregroundColor(Color.white)
                    
                    Text("👋")
                        .font(.system(size: 35))
                        .padding(.vertical, 5)
                }
            }
        }
            .onAppear {
                filteredContacts = contacts
            }
            .onChange(of: editFriendContactId) { newEditFriendContactId in
                if (newEditFriendContactId == nil) {
                    updateFilteredContactsList(newSearchTerm: searchText)
                }
            }
    }
    
    func updateFilteredContactsList(newSearchTerm: String) -> Void {
        if (searchText.replacingOccurrences(of: " ", with: "") == "") {
            filteredContacts = contacts
        } else {
            filteredContacts = contacts.filter { contactMatchesSearchTerm(searchTerm: newSearchTerm, contact: $0) }
        }
    }
    
    func contactMatchesSearchTerm(searchTerm: String, contact: Contact) -> Bool {
        let contactNameFormatted = (contact.firstName + contact.lastName).lowercased().replacingOccurrences(of: " ", with: "")
        let searchTermFormatted = searchTerm.lowercased().replacingOccurrences(of: " ", with: "")
        return contactNameFormatted.contains(searchTermFormatted)
    }
    
    func handleContactTap(filteredContactIndex: Int) -> Void {
        hideKeyboard()
        setCurrentlyAddedForContact(filteredContactIndex: filteredContactIndex)
        addFriendFromContact(filteredContacts[filteredContactIndex])
    }
    
    func setCurrentlyAddedForContact(filteredContactIndex: Int) -> Void {
        for i in 0...contacts.count - 1 {
            if (contacts[i].id == filteredContacts[filteredContactIndex].id) {
                contacts[i].currentlyAdded = true
                break
            }
        }
        filteredContacts[filteredContactIndex].currentlyAdded = true
    }
    
    func isFilteredContactVisible() -> Bool {
        var filteredContactVisible = false
        for friend in filteredContacts {
            if !friend.currentlyAdded {
                filteredContactVisible = true
            }
        }
        return filteredContactVisible
    }
}
