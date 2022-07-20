//
//  LandingPage.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/16/21.
//

import SwiftUI

struct LandingPage: View {
    @Binding var currentPage: Pages
    @Binding var isScanning: Bool
    @Binding var isUploading: Bool
    @Binding var items: [ReciptItem]
    @Binding var friends: [Person]
    @Binding var tax: CurrencyObject
    
    @State var isCropConfirmationModalOpen = false
    
    var IS_SIMULATION: Bool = false
    
    var body: some View {
        VStack {
            Text("Welcome to DVY")
                .font(.system(size: 45, weight: .semibold))
                .foregroundColor(Color.white)
                .padding(.bottom, 10)
            
            Text("🍕 💸 🍻")
                .font(.system(size: 40))
                .padding(.bottom, 10)
            
            Text("Input a receipt to start")
                .font(.system(size: 30))
                .foregroundColor(Color.white)
                .padding(.bottom, 10)
            
            HStack {
                Button(action: { startScan() }) {
                    Text("Scan 📸")
                }
                    .buttonStyle(GreenButton())
                
                Button(action: { isCropConfirmationModalOpen = true }) {
                    Text("Upload 📂")
                }
                    .buttonStyle(GreenButton())
                    .padding(.leading)
            }
        }
        
        if (isCropConfirmationModalOpen) {
            CropConfirmationModal(
                isCropConfirmationModalOpen: $isCropConfirmationModalOpen,
                uploadPhoto: uploadPhoto
            )
        }
    }
    
    func startScan() {
        for var friend in friends {
            friend.items = []
        }
        
        tax = CurrencyObject(price: 0.0)
        currentPage = .scanConfirmationPage
        
        if (IS_SIMULATION) {
            simulateScan()
        } else {
            performScan()
        }
    }
    
    func simulateScan() {
        items = testItems
    }
    
    func performScan() {
        items = []
        isScanning = true
    }
    
    func uploadPhoto() {
        isUploading = true
        currentPage = .scanConfirmationPage
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
