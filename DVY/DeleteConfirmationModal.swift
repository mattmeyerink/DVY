//
//  DeleteConfirmationModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 8/19/22.
//

import SwiftUI

struct DeleteConfirmationModal: View {
    @State var otherModalOpening: Bool
    @State var modalHeight: Int
    @State var message: String
    @State var deleteButtonText: String
    
    @State var closeModal: () -> Void
    @State var delete: () -> Void
    
    @State var modalTitle: String = "You Sure? 😱"
    
    var body: some View {
        Modal(
            modalTitle: $modalTitle,
            otherModalOpening: $otherModalOpening,
            closeModal: closeModal,
            modalHeight: modalHeight
        ) {
            VStack {
                Text(message)
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                HStack {
                    Button(action: closeModal) {
                        Text("Cancel")
                    }
                        .buttonStyle(RedButton())
                    
                    Spacer()
                    
                    Button(action: delete) {
                        Text(deleteButtonText)
                    }
                        .buttonStyle(GreenButton())
                }
            }
            .padding(.horizontal)
        }
    }
}
