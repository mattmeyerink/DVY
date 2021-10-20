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
    @Binding var tax: CurrencyObject
    @Binding var total: CurrencyObject

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
                    Text("Tax: " + tax.priceFormatted)
                        .font(.system(size: 25, weight: .semibold))
                    Spacer()
                    Text("Total: " + total.priceFormatted)
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
