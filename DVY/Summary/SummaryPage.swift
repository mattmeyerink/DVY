//
//  SummaryPage.swift
//  DVY
//
//  Created by Matthew Meyerink on 1/6/22.
//

import SwiftUI

struct SummaryPage: View {
    @Binding var currentPage: Pages
    @Binding var friends: [Person]
    @Binding var tax: CurrencyObject
    @Binding var tip: CurrencyObject
    
    @State var friendExpanded: Int? = nil
    
    @State var isNewScanModalOpen: Bool = false
    
    var subtotal: Double
    
    init(
        currentPage: Binding<Pages>,
        friends: Binding<[Person]>,
        tax: Binding<CurrencyObject>,
        tip: Binding<CurrencyObject>
    ) {
        self._currentPage = currentPage
        self._friends = friends
        self._tax = tax
        self._tip = tip
    
        subtotal = 0.0
        for friend in self.friends {
            for item in friend.items {
                subtotal += item.price
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text("Summary")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 15)
                
                ScrollView {
                    ForEach(friends.indices, id: \.self) { i in
                        VStack {
                            HStack {
                                if (i == self.friendExpanded) {
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 18, weight: .heavy))
                                } else {
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 18, weight: .heavy))
                                }
                                
                                Text(friends[i].firstName + " " + friends[i].lastName)
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.leading, 5)
                                
                                Spacer()
                                
                                Text(calculateFriendTotal(friend: friends[i]).priceFormatted)
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.trailing, 5)
                            }
                                .padding(.bottom, 5)
                            
                            if (i == self.friendExpanded) {
                                ForEach(friends[i].items.indices, id: \.self) { j in
                                    HStack {
                                        Text(friends[i].items[j].name)
                                        
                                        Spacer()
                                        
                                        Text(friends[i].items[j].priceFormatted)
                                    }
                                        .padding(.horizontal, 5)
                                }
                                
                                HStack {
                                    Text("Tax Contribution")
                                    
                                    Spacer()
                                    
                                    Text(calculateFriendTaxContribution(friend: friends[i]).priceFormatted)
                                }
                                    .padding(.horizontal, 5)
                                    .padding(.top, 5)
                                
                                HStack {
                                    Text("Tip Contribution")
                                    
                                    Spacer()
                                    
                                    Text(calculateFriendTipContribution(friend: friends[i]).priceFormatted)
                                }
                                    .padding(.horizontal, 5)
                                
                                HStack {
                                    Text("Subtotal")
                                    
                                    Spacer()
                                    
                                    Text(calculateFriendSubtotal(friend: friends[i]).priceFormatted)
                                }
                                    .padding(.horizontal, 5)
                            }
                        }
                            .padding()
                            .background(Color(red: friends[i].color.red, green: friends[i].color.green, blue: friends[i].color.blue))
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                            .cornerRadius(10)
                            .onTapGesture {
                                self.toggleExpandedFriend(index: i)
                            }
                    }
                }
            }
                .padding(.horizontal)
            
            if (isNewScanModalOpen) {
                NewScanConfirmationModal(
                    currentPage: $currentPage,
                    isNewScanModalOpen: $isNewScanModalOpen,
                    friends: $friends,
                    tax: $tax
                )
            }
        }
        .navigationBarItems(
            leading: Button(action: { currentPage = .assignItemsPage }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 15, weight: .bold))
                    
                    Text("Back")
                        .fontWeight(.bold)
                }
                    .foregroundColor(.white)
            },
            trailing: Button(action: openNewScanModal) {
                HStack {
                    Text("Start New Scan")
                        .fontWeight(.bold)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 15, weight: .bold))
                }
                    .foregroundColor(.white)
            }
        )
    }
    
    func calculateFriendSubtotal(friend: Person) -> CurrencyObject {
        var friendSubtotal = 0.0
        for item in friend.items {
            friendSubtotal += item.price
        }
        
        return CurrencyObject(price: friendSubtotal)
    }
    
    func calculateFriendTaxContribution(friend: Person) -> CurrencyObject {
        let friendSubtotal = calculateFriendSubtotal(friend: friend).price
        return CurrencyObject(price: (friendSubtotal / subtotal) * tax.price)
    }
    
    func calculateFriendTipContribution(friend: Person) -> CurrencyObject {
        let friendSubtotal = calculateFriendSubtotal(friend: friend).price
        return CurrencyObject(price: (friendSubtotal / subtotal) * tip.price)
    }
    
    func calculateFriendTotal(friend: Person) -> CurrencyObject {
        let friendSubtotal = calculateFriendSubtotal(friend: friend).price
        let taxContribution = calculateFriendTaxContribution(friend: friend).price
        let tipContribution = calculateFriendTipContribution(friend: friend).price
        
        return CurrencyObject(price: (friendSubtotal + taxContribution + tipContribution))
    }
    
    func toggleExpandedFriend(index: Int) {
        if (self.friendExpanded == index) {
            self.friendExpanded = nil
        } else {
            self.friendExpanded = index
        }
    }
    
    func openNewScanModal() {
        isNewScanModalOpen = true
    }
}
