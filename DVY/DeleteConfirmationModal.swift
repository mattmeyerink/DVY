//
//  DeleteConfirmationModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 8/19/22.
//

import SwiftUI

struct DeleteConfirmationModal: View {
    @State var modalTitle: String = "You Sure? 😱"
    @State var othermModalOpening: Bool
    @State var modalHeight: Int
    @State var message: String
    
    @State var closeModal: () -> Void
    @State var delete: () -> Void
    
    var body: some View {
        Modal(
            modalTitle: $modalTitle,
            otherModalOpening: $othermModalOpening,
            closeModal: closeModal,
            modalHeight: modalHeight
        ) {
            VStack {
                Text(message)
                
                HStack {
                    Button(action: closeModal) {
                        Text("Cancel")
                    }
                        .buttonStyle(RedButton())
                    
                    Button(action: delete) {
                        Text("Delete")
                    }
                        .buttonStyle(GreenButton())
                }
            }
        }
    }
}
