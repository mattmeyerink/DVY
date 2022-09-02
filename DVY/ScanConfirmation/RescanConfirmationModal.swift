//
//  RescanConfirmationModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 1/16/22.
//

import SwiftUI

struct RescanConfirmationModal: View {
    @Binding var currentPage: Pages
    @Binding var isRescanModalOpen: Bool
    @Binding var items: [ReciptItem]
    @Binding var friends: [Person]
    
    @State var modalTitle: String = "Scan Tips 📸"
    @State var otherModalOpening: Bool = false
    
    var body: some View {
        Modal(
            modalTitle: $modalTitle,
            otherModalOpening: $otherModalOpening,
            closeModal: closeRescanModal,
            modalHeight: 450
        ) {
            VStack {
                Text("1. Make sure all 4 corners of the receipt are visible in the scan.")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                Text("2. Crop the scan to only include the items and their prices.")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                Text("2. Scan the receipt on a dark colored surface.")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                Text("4. Make sure the receipt isn't scanned multiple times.")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
            }
                .padding(.horizontal, 15)

            
            Spacer()
            
            HStack {
                Button(action: closeRescanModal) {
                    Text("Cancel")
                }
                    .buttonStyle(RedButton())
                
                Spacer()
                
                Button(action: startRescan) {
                    Text("Re-Scan")
                }
                    .buttonStyle(GreenButton())
            }
                .padding(.horizontal, 15)
                .padding(.bottom, 15)
        }
    }
    
    func closeRescanModal() {
        isRescanModalOpen = false
    }
    
    func startRescan() {
        items = []
        for i in 0..<friends.count {
            friends[i].items = []
        }
        
        currentPage = .landingPage
        closeRescanModal()
    }
}
