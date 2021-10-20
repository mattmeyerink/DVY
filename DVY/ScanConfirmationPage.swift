//
//  ScanConfirmationPage.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/16/21.
//

import SwiftUI

struct ScanConfirmationPage: View {
    @Binding var isConfirmingScan: Bool
    @Binding var items: [ReciptItem]
    
    var reciptItems: [ReciptItem] = [
        ReciptItem(name: "Pizza", price: 5.0),
        ReciptItem(name: "Burger", price: 2.0),
        ReciptItem(name: "Oberon", price: 1.5)
    ]
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text("Does this look right?")
                    .font(.system(size: 30, weight: .semibold))
                    .padding(.vertical, 15)
                    .foregroundColor(Color.white)
                
                ScrollView {
                    ForEach(items) { item in
                        HStack {
                            Text(item.name)
                                .font(.system(size: 20, weight: .semibold))
                                .padding(.leading, 5)
                            Spacer()
                            Text(item.priceFormatted)
                                .font(.system(size: 20, weight: .semibold))
                                .padding(.trailing, 5)
                        }
                            .padding()
                            .background(Color(red: 0.95, green: 0.8, blue: 0.5))
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                            .cornerRadius(10)
                    }
                }
                
                HStack {
                    Text("Tax: $1.00")
                        .font(.system(size: 25, weight: .semibold))
                    Spacer()
                    Text("Total: $8.50")
                        .font(.system(size: 25, weight: .semibold))
                }
                    .foregroundColor(Color.white)
                    .padding(.vertical)
                .padding(.horizontal)
            }
                .padding(.horizontal)
        }
        .navigationBarItems(
            leading: Button(action: {self.isConfirmingScan = false}) {
                Text("< Re-Scan").foregroundColor(Color.white)
            },
            trailing: NavigationLink(destination: AddFriendsPage()) {
                Text("Next >").foregroundColor(Color.white)
            }
        )
    }
}
