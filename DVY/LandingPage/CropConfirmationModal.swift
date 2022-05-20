//
//  CropConfirmationModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 5/19/22.
//

import SwiftUI

struct CropConfirmationModal: View {
    @Binding var isCropConfirmationModalOpen: Bool
    
    @State var uploadPhoto: () -> Void
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Crop First")
                        .font(.system(size: 35, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top, 15)
                    
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 35, weight: .semibold))
                        .padding(.top, 15)
                        .onTapGesture() {
                            isCropConfirmationModalOpen = false
                        }
                }
                    .padding(.horizontal)
                
                Spacer()
                
                Text("For the best result crop your photo so that only the receipt is in the photo.")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .regular))
                    .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Button(action: { isCropConfirmationModalOpen = false }) {
                        Text("Cancel")
                    }
                        .buttonStyle(RedButton())
                    
                    Spacer()
                    
                    Button(action: { uploadPhoto() }) {
                        Text("Confirm")
                    }
                        .buttonStyle(GreenButton())
                }
                    .padding(.horizontal)
                    .padding(.bottom)
            }
                .frame(width: 350, height: 260, alignment: .center)
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
