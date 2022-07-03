//
//  Modal.swift
//  DVY
//
//  Created by Matthew Meyerink on 6/28/22.
//

import SwiftUI

struct Modal<Content: View>: View {
    @Binding var modalTitle: String
    let content: Content

    let closeModal: () -> Void
    let modalHeight: Int
    
    init(
        modalTitle: Binding<String>,
        closeModal: @escaping () -> Void,
        modalHeight: Int,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        
        self.closeModal = closeModal
        self.modalHeight = modalHeight
        
        self._modalTitle = modalTitle
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text(modalTitle)
                        .font(.system(size: 35, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top, 15)
                    
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 35, weight: .semibold))
                        .padding(.top, 15)
                        .onTapGesture() {
                            closeModal()
                        }
                }
                    .padding(.horizontal)
                    .padding(.bottom)
                
                content
            }
                .frame(width: 350, height: Double(modalHeight), alignment: .center)
                .background(Color(red: 0.1, green: 0.1, blue: 0.1))
                .cornerRadius(15)
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                    UITableView.appearance().backgroundColor = .systemGroupedBackground
                }
        }
    }
}
