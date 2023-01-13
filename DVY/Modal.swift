//
//  Modal.swift
//  DVY
//
//  Created by Matthew Meyerink on 6/28/22.
//

import SwiftUI

struct Modal<Content: View>: View {
    @Binding var modalTitle: String
    @Binding var otherModalOpening: Bool
    let content: Content

    let closeModal: () -> Void
    let modalHeight: Int
    
    init(
        modalTitle: Binding<String>,
        otherModalOpening: Binding<Bool>,
        closeModal: @escaping () -> Void,
        modalHeight: Int,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        
        self.closeModal = closeModal
        self.modalHeight = modalHeight
        
        self._modalTitle = modalTitle
        self._otherModalOpening = otherModalOpening
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
                .modifier(ModalBackgroundModifier())
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                    if (!otherModalOpening) {
                        UITableView.appearance().backgroundColor = .systemGroupedBackground
                    }
                }
        }
    }
}

// This modifier adds a property to modals to allow the background color to show
// properly in modals where there is a form with a text input.
struct ModalBackgroundModifier: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}
