//
//  ContentView.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/15/21.
//

import SwiftUI

struct ContentView: View {
    @State var currentPage: String = "landingPage"
    @State var isScanning: Bool = false
    @State var items: [ReciptItem] = []
    @State var friends: [Person] = []
    @State var tax: CurrencyObject = CurrencyObject(price: 0.0)
    @State var tip: CurrencyObject = CurrencyObject(price: 0.0)
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            if (self.currentPage == "landingPage"){
                LandingPage(currentPage: $currentPage, isScanning: $isScanning)
            }
            
            if (self.currentPage == "scanConfirmationPage") {
                NavigationView {
                    ScanConfirmationPage(currentPage: $currentPage, items: $items)
                }
            }
            
            if (self.currentPage == "addFriendsPage") {
                NavigationView {
                    AddFriendsPage(currentPage: $currentPage, friends: $friends)
                }
            }
            
            if (self.currentPage == "assignItemsPage") {
                NavigationView {
                    AssignItemsPage(currentPage: $currentPage, friends: $friends, items: $items)
                }
            }
            
            if (self.currentPage == "taxTipPage") {
                NavigationView {
                    TaxTipPage(currentPage: $currentPage, tax: $tax, tip: $tip, taxString: tax.priceFormatted)
                }
            }
        }
            .sheet(isPresented: $isScanning) {
                ScanDocumentView(items: $items, tax: $tax)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
