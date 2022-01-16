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
    
    var body: some View {
        VStack {
            Text("Welcome to DVY")
                .font(.system(size: 45, weight: .semibold))
                .foregroundColor(Color.white)
                .padding(.bottom, 10)
            
            Text("Scan a recipt to start")
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
        self.items = []
        self.tax = CurrencyObject(price: 0.0)
        self.currentPage = "scanConfirmationPage"
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
