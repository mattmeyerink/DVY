//
//  SummaryPage.swift
//  DVY
//
//  Created by Matthew Meyerink on 1/6/22.
//

import SwiftUI

struct SummaryPage: View {
    @Binding var currentPage: String
    @Binding var friends: [Person]
    @Binding var tax: CurrencyObject
    @Binding var tip: CurrencyObject
    
    var subtotal: Double
    
    init(currentPage: Binding<String>, friends: Binding<[Person]>, tax: Binding<CurrencyObject>, tip: Binding<CurrencyObject>) {
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
                                Text(friends[i].firstName + " " + friends[i].lastName)
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.leading, 5)
                                
                                Spacer()
                                
                                Text(calculateFriendTotal(friend: friends[i]).priceFormatted)
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.trailing, 5)
                            }
                        }
                            .padding()
                            .background(Color(red: friends[i].color.red, green: friends[i].color.green, blue: friends[i].color.blue))
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                            .cornerRadius(10)
                    }
                }
            }
                .padding(.horizontal)
        }
        .navigationBarItems(
            leading: Button(action: { self.currentPage = "assignItemsPage" }) {
                Text("< Back").foregroundColor(Color.white)
            }
        )
    }
    
    func calculateFriendTotal(friend: Person) -> CurrencyObject {
        var friendTotal = 0.0
        for item in friend.items {
            friendTotal += item.price
        }
        
        let taxContribution = (friendTotal / subtotal) * tax.price
        let  tipContribution = (friendTotal / subtotal) * tip.price
        
        return CurrencyObject(price: (friendTotal + taxContribution + tipContribution))
    }
}
