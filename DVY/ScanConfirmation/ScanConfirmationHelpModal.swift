//
//  ScanConfirmationHelpModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 2/11/22.
//

import SwiftUI

struct ScanConfirmationHelpModal: View {
    @Binding var isScanConfirmationHelpOpen: Bool
    
    @State var modalTitle: String = "Help"
    
    var body: some View {
        Modal(
            modalTitle: $modalTitle,
            closeModal: closeScanConfirmationHelpModal,
            modalHeight: 400
        ) {
            VStack {
                Text("1. Tap any extra items you would like to remove.")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                Text("2. Remove any tax or tip entries. They will be calculated on the next page.")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                Text("3. Tap any items you would like to split between people and use the ÷ feature.")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.bottom, 25)
                Text("*If the items and prices in the scan are incorrect, hit \"Re-Scan.\"")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
            }
                .padding(.horizontal)
                .padding(.bottom)
        }
    }
    
    func closeScanConfirmationHelpModal() {
        isScanConfirmationHelpOpen = false
    }
}
