//
//  NewScanConfirmationModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 1/16/22.
//

import SwiftUI

struct NewScanConfirmationModal: View {
    @Binding var currentPage: String
    @Binding var isNewScanModalOpen: Bool
    @Binding var friends: [Person]
    @Binding var tax: CurrencyObject
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Start New Scan")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top, 15)
                
                Spacer()
                
                VStack {
                    Text("Are you sure you want to start a new scan? All data from the current scan will be lost.")
                        .font(.system(size: 20, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                }
                    .padding(.horizontal, 15)

                
                Spacer()
                
                HStack {
                    Button(action: { closeNewScanModal() }) {
                        Text("Cancel")
                    }
                        .buttonStyle(GreenButton())
                    
                    Spacer()
                    
                    Button(action: { startNewScan() }) {
                        Text("Rescan")
                    }
                        .buttonStyle(GreenButton())
                }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 15)
            }
                .frame(width: 350, height: 275, alignment: .center)
                .background(Color(red: 0.1, green: 0.1, blue: 0.1)).cornerRadius(15)
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                    UITableView.appearance().backgroundColor = .systemGroupedBackground
                }
        }
    }
    
    func closeNewScanModal() {
        isNewScanModalOpen = false
    }
    
    func startNewScan() {
        currentPage = "landingPage"
        friends = []
        tax = CurrencyObject(price: 0.0)
        closeNewScanModal()
    }
}
