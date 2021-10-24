//
//  FriendActionModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/23/21.
//

import SwiftUI

struct FriendActionModal: View {
    @Binding var isFriendActionOpen: Bool
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            HStack {
                Image(systemName: "arrowshape.turn.up.backward.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .semibold))
                    .padding(.horizontal, 10)
                    .padding(.bottom, 15)
                    .onTapGesture() {
                        closePopup()
                    }
                
                Image(systemName: "trash.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .semibold))
                    .padding(.horizontal, 10)
                    .padding(.bottom, 15)
                
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .semibold))
                    .padding(.horizontal, 10)
                    .padding(.bottom, 15)
            }
                .frame(width: 225, height: 75, alignment: .center)
                .padding(.top, 15)
                .background(Color(red: 0.1, green: 0.1, blue: 0.1)).cornerRadius(15)
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                    UITableView.appearance().backgroundColor = .systemGroupedBackground
                }
        }
    }
    
    func closePopup() {
        isFriendActionOpen = false
    }
}
