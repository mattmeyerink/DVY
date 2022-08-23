//
//  ContentView.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/15/21.
//

import SwiftUI
import Contacts

enum Pages {
    case landingPage
    case scanConfirmationPage
    case taxTipPage
    case addFriendsPage
    case assignItemsPage
    case summaryPage
}

struct ContentView: View {
    @State var currentPage: Pages = .landingPage
    @State var isScanning: Bool = false
    @State var isUploading: Bool = false
    @State var items: [ReciptItem] = []
    @State var friends: [Person] = []
    @State var tax: CurrencyObject = CurrencyObject(price: 0.0)
    @State var tip: CurrencyObject = CurrencyObject(price: 0.0)
    @State var tipSelectionOption: Int = 1
    @State var customTip: CurrencyObject = CurrencyObject(price: 0.0)
    
    @State var store = FriendsStore()
    @State var contacts: [Contact] = []
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            switch currentPage {
            case .landingPage:
                LandingPage(
                    currentPage: $currentPage,
                    isScanning: $isScanning,
                    isUploading: $isUploading,
                    items: $items,
                    friends: $friends,
                    tax: $tax
                )
            case .scanConfirmationPage:
                NavigationView {
                    ScanConfirmationPage(
                        currentPage: $currentPage,
                        items: $items,
                        friends: $friends
                    )
                }
            case .taxTipPage:
                NavigationView {
                    TaxTipPage(
                        currentPage: $currentPage,
                        tax: $tax,
                        tip: $tip,
                        items: $items,
                        friends: $friends,
                        taxString: tax.priceFormatted,
                        tipSelectionOption: $tipSelectionOption,
                        customTip: $customTip
                    )
                }
            case .addFriendsPage:
                NavigationView {
                    AddFriendsPage(
                        currentPage: $currentPage,
                        friends: $friends,
                        contacts: $contacts,
                        previouslyAddedFriends: store.previouslyAddedFriends,
                        saveFriendAction: saveFriendAction
                    )
                }
            case .assignItemsPage:
                NavigationView {
                    AssignItemsPage(
                        currentPage: $currentPage,
                        friends: $friends,
                        items: $items
                    )
                }
            case .summaryPage:
                NavigationView {
                    SummaryPage(
                        currentPage: $currentPage,
                        friends: $friends,
                        tax: $tax,
                        tip: $tip
                    )
                }
            }
        }
            .sheet(isPresented: $isScanning) {
                ScanDocumentView(items: $items, tax: $tax)
            }
            .sheet(isPresented: $isUploading) {
                ImagePicker(items: $items, tax: $tax)
            }
            .onAppear {
                loadFriendsFromLocalStore()
                
                Task.init {
                    await fetchAllContacts()
                }
            }
    }
    
    func saveFriendAction(friends: [Person]) -> Void {
        FriendsStore.save(friends: friends) { result in
            if case .failure(let error) = result {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func loadFriendsFromLocalStore() -> Void {
        FriendsStore.load { result in
            switch result {
            case .failure(let error):
                saveFriendAction(friends: [])
                fatalError(error.localizedDescription)
            case .success(let friends):
                store.previouslyAddedFriends = friends.sorted(by: { $0.useCount > $1.useCount })
                if store.previouslyAddedFriends.count < 1 { return }
                for i in 0...store.previouslyAddedFriends.count - 1 {
                    store.previouslyAddedFriends[i].isVisible = true
                }
            }
        }
    }
    
    func fetchAllContacts() async {
        let store = CNContactStore()
        
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        
        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, result in
                let firstName = contact.givenName
                let lastName = contact.familyName
                var phoneNumber = ""
                
                for number in contact.phoneNumbers {
                    if (number.label == CNLabelPhoneNumberMobile) {
                        phoneNumber = number.value.stringValue
                        break
                    }
                }
                
                let newContact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
                contacts.append(newContact)
            })
        } catch {
            contacts = []
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
