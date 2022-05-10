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
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            HStack {
                VStack {
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .semibold))
                        .padding(.horizontal, 20)
                        .padding(.bottom, 15)
                        .onTapGesture() {
                            closePopup()
                        }
                    
                    Text("Back")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .regular))
                        .padding(.bottom, 15)
                        .padding(.top, 5)
                }
                
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
                            editFriend()
                        }
                    
                    Text("Edit")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .regular))
                        .padding(.bottom, 15)
                        .padding(.top, 5)
                }
            }
                .frame(width: 300, height: 125, alignment: .center)
                .padding(.top, 15)
                .background(Color(red: 0.1, green: 0.1, blue: 0.1)).cornerRadius(15)
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                    if (!isEditFriendOpen) {
                        UITableView.appearance().backgroundColor = .systemGroupedBackground
                    }
                }
        }
    }
    
    func closePopup() {
        self.actionFriendIndex = nil
        self.isFriendActionOpen = false
    }
}
