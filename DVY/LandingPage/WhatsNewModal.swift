//
//  WhatsNewModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 11/5/22.
//

import SwiftUI

struct WhatsNewModal: View {
    @Binding var updatesSinceLastAccess: [DVYVersion]
    
    @State var modalTitle: String = "New Stuff 🤩"
    @State var otherModalOpening: Bool = false
    @State var modalHeight: Int = 400
    
    var body: some View {
        Modal(
            modalTitle: $modalTitle,
            otherModalOpening: $otherModalOpening,
            closeModal: closeWhatsNewModal,
            modalHeight: modalHeight
        ) {
            ScrollView {
                ForEach(updatesSinceLastAccess.indices, id: \.self) { i in
                    VersionUpdateText(version: updatesSinceLastAccess[i])
                }
            }
        }
    }
    
    func closeWhatsNewModal() -> Void {
        updatesSinceLastAccess = []
    }
}
