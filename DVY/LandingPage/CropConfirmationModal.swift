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
    @State var modalTitle: String = "Crop First"
    @State var otherModalOpening: Bool = false
    
    var body: some View {
        Modal(
            modalTitle: $modalTitle,
            otherModalOpening: $otherModalOpening,
            closeModal: closeCropConfirmationModal,
            modalHeight: 260
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
