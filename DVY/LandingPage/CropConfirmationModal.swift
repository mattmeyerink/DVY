//
//  CropConfirmationModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 5/19/22.
//

import SwiftUI

struct CropConfirmationModal: View {
    @Binding var isCropConfirmationModalOpen: Bool
    
    @State var uploadPhoto: () -> Void
    
    var body: some View {
        Modal(
            isOpen: $isCropConfirmationModalOpen,
            closeModal: closeCropConfirmationModal,
            modalHeight: 260,
            modalTitle: "Crop First"
        ) {
            Text("For the best result crop your photo so that only the receipt is in the photo.")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .regular))
                .padding(.horizontal)
            
            Spacer()
            
            HStack {
                Button(action: closeCropConfirmationModal) {
                    Text("Cancel")
                }
                    .buttonStyle(RedButton())
                
                Spacer()
                
                Button(action: uploadPhoto) {
                    Text("Confirm")
                }
                    .buttonStyle(GreenButton())
            }
                .padding()
        }
    }
    
    func closeCropConfirmationModal() -> Void {
        isCropConfirmationModalOpen = false
    }
}
