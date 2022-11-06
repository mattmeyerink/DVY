//
//  WhatsNewModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 11/5/22.
//

import SwiftUI

struct WhatsNewModal: View {
    @State var modalTitle: String = "New Stuff 🤩"
    @State var otherModalOpening: Bool = false
    @State var modalHeight: Int = 400
    
    @State var closeWhatsNewModal: () -> Void
    
    var body: some View {
        Modal(
            modalTitle: $modalTitle,
            otherModalOpening: $otherModalOpening,
            closeModal: closeWhatsNewModal,
            modalHeight: modalHeight
        ) {
            Text("This will be the text about the updates")
        }
    }
}
