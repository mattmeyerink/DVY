//
//  RescanConfirmationModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 1/16/22.
//

import SwiftUI

struct RescanConfirmationModal: View {
    @Binding var currentPage: String
    @Binding var isRescanModalOpen: Bool
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Tips for Scanning")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top, 15)
                
                Spacer()
                
                VStack {
                    Text("1. Scan the receipt on a dark colored surface.")
                        .font(.system(size: 20, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    Text("2. Crop the scan to only include the items and thier prices.")
                        .font(.system(size: 20, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    Text("3. Make sure the recipt isn't scanned multiple times.")
                        .font(.system(size: 20, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                }
                    .padding(.horizontal, 15)

                
                Spacer()
                
                HStack {
                    Button(action: { closeRescanModal() }) {
                        Text("Cancel")
                    }
                        .buttonStyle(GreenButton())
                    
                    Spacer()
                    
                    Button(action: { startRescan() }) {
                        Text("Rescan")
                    }
                        .buttonStyle(GreenButton())
                }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 15)
            }
                .frame(width: 350, height: 350, alignment: .center)
                .background(Color(red: 0.1, green: 0.1, blue: 0.1)).cornerRadius(15)
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                    UITableView.appearance().backgroundColor = .systemGroupedBackground
                }
        }
    }
    
    func closeRescanModal() {
        isRescanModalOpen = false
    }
    
    func startRescan() {
        currentPage = "landingPage"
        closeRescanModal()
    }
}
