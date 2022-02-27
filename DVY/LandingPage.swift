//
//  LandingPage.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/16/21.
//

import SwiftUI

struct LandingPage: View {
    @Binding var currentPage: String
    @Binding var isScanning: Bool
    @Binding var items: [ReciptItem]
    @Binding var friends: [Person]
    @Binding var tax: CurrencyObject
    
    var IS_SIMULATION: Bool = false
    
    var body: some View {
        VStack {
            Text("Welcome to DVY")
                .font(.system(size: 45, weight: .semibold))
                .foregroundColor(Color.white)
                .padding(.bottom, 10)
            
            Text("Scan a receipt to start")
                .font(.system(size: 30))
                .foregroundColor(Color.white)
                .padding(.bottom, 10)
            
            Button(action: { startScan() }) {
                Text("Scan")
            }
                .buttonStyle(GreenButton())
        }
    }
    
    func startScan() {
        for friend in self.friends {
            friend.items = []
        }
        
        self.tax = CurrencyObject(price: 0.0)
        self.currentPage = "scanConfirmationPage"
        
        if (IS_SIMULATION) {
            simulateScan()
        } else {
            performScan()
        }
    }
    
    func simulateScan() {
        self.items = testItems
    }
    
    func performScan() {
        self.items = []
        self.isScanning = true
    }
}

struct GreenButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 25, weight: .bold))
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
            .background(Color(red: 0.2, green: 0.9, blue: 0.25))
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.85 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

var testItems: [ReciptItem] = [
    ReciptItem(name: "Rustic Burger", price: 15.08),
    ReciptItem(name: "Oberon", price: 7.00),
    ReciptItem(name: "Two Hearted", price: 8.00),
    ReciptItem(name: "Chicken Tenders", price: 10.01),
    ReciptItem(name: "Moscow Mule", price: 9.50),
    ReciptItem(name: "Chicken Tacos", price: 13.00),
    ReciptItem(name: "Sweet Tea", price: 3.50),
    ReciptItem(name: "Onion Rings", price: 8.25),
    ReciptItem(name: "Grilled Chicken Sandwitch", price: 12.13),
    ReciptItem(name: "All Day IPA", price: 7.00),
]
