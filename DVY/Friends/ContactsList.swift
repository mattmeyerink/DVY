//
//  ContactsList.swift
//  DVY
//
//  Created by Matthew Meyerink on 8/3/22.
//

import SwiftUI

struct ContactsList: View {
    @Binding var contacts: [Contact]
    
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
            ForEach(filteredContacts.indices, id: \.self) { i in
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
            }
        }
            .onAppear {
                filteredContacts = contacts
            }
    }
    
    func updateFilteredContactsList(newSearchTerm: String) {
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
}
