//
//  DeleteConfirmationModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 8/19/22.
//

import SwiftUI

struct DeleteConfirmationModal: View {
    @State var modalTitle: String
    @State var othermModalOpening: Bool
    @State var closeModal: () -> Void
    @State var modalHeight: Int
    @State var message: String
    
    var body: some View {
        Modal(
            modalTitle: $modalTitle,
            otherModalOpening: $othermModalOpening,
            closeModal: closeModal,
            modalHeight: modalHeight
        ) {
            Text(message)
        }
    }
}
