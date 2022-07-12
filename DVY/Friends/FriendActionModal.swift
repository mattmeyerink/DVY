//
//  FriendActionModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/23/21.
//

import SwiftUI

struct FriendActionModal: View {
    @Binding var isFriendActionOpen: Bool
    @Binding var isEditFriendOpen: Bool
    @Binding var actionFriendIndex: Int?
    
    @State var deleteFriend: () -> Void
    @State var editFriend: () -> Void
    
    @State var modalTitle: String = "Actions"
    @State var otherModalOpening: Bool = false
    
    var body: some View {
        Modal(
            modalTitle: $modalTitle,
            otherModalOpening: $otherModalOpening,
            closeModal: closePopup,
            modalHeight: 225
        ) {
            HStack {
                VStack {
                    Image(systemName: "trash.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .semibold))
                        .padding(.horizontal, 20)
                        .padding(.bottom, 15)
                        .onTapGesture() {
                            deleteFriend()
                        }
                    
                    Text("Delete")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .regular))
                        .padding(.bottom, 15)
                }
                
                VStack {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .semibold))
                        .padding(.horizontal, 20)
                        .padding(.bottom, 15)
                        .onTapGesture() {
                            otherModalOpening = true
                            editFriend()
                        }
                    
                    Text("Edit")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .regular))
                        .padding(.bottom, 15)
                        .padding(.top, 5)
                }
            }
        }
    }
    
    func closePopup() {
        self.actionFriendIndex = nil
        self.isFriendActionOpen = false
    }
}
