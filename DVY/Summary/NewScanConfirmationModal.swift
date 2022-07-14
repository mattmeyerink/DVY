//
//  NewScanConfirmationModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 1/16/22.
//

import SwiftUI

struct NewScanConfirmationModal: View {
    @Binding var currentPage: Pages
    @Binding var isNewScanModalOpen: Bool
    @Binding var friends: [Person]
    @Binding var tax: CurrencyObject
    
    @State var modalTitle: String = "New Scan"
    @State var otherModalOpening: Bool = false
    
    var body: some View {
        Modal(
            modalTitle: $modalTitle,
            otherModalOpening: $otherModalOpening,
            closeModal: closeNewScanModal,
            modalHeight: 325
        ) {
            VStack {
                Text("Are you sure you want to start a new scan?")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("All data from the current scan will be lost!")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)

                Spacer()
                
                HStack {
                    Button(action: closeNewScanModal) {
                        Text("Cancel")
                    }
                        .buttonStyle(RedButton())
                    
                    Spacer()
                    
                    Button(action: startNewScan) {
                        Text("Re-Scan")
                    }
                        .buttonStyle(GreenButton())
                }
            }
                .padding()
        }
    }
    
    func closeNewScanModal() {
        isNewScanModalOpen = false
    }
    
    func startNewScan() {
        currentPage = .landingPage
        friends = []
        tax = CurrencyObject(price: 0.0)
        closeNewScanModal()
    }
}
