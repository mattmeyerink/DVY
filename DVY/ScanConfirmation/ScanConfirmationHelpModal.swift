//
//  ScanConfirmationHelpModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 2/11/22.
//

import SwiftUI

struct ScanConfirmationHelpModal: View {
    @Binding var isScanConfirmationHelpOpen: Bool
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("What Do I Do?")
                        .font(.system(size: 35, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top, 15)
                    
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 35, weight: .semibold))
                        .padding(.top, 15)
                        .onTapGesture() {
                            closeScanConfirmationHelpModal()
                        }
                }
                    .padding(.horizontal)
                
                
                Spacer()
                
                VStack {
                    Text("1. Tap any extra items you would like to remove.")
                        .font(.system(size: 20, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    Text("2. Remove any tax or tip entries. They will be calculated on the next page.")
                        .font(.system(size: 20, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    Text("3. Tap any items you would like to split between people and use the ÷ feature.")
                        .font(.system(size: 20, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .padding(.bottom, 25)
                    Text("*If the items and prices in the scan are incorrect, hit \"Re-Scan.\"")
                        .font(.system(size: 20, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                }
                    .padding(.horizontal)
                    .padding(.bottom)
            }
                .frame(width: 350, height: 400, alignment: .center)
                .background(Color(red: 0.1, green: 0.1, blue: 0.1)).cornerRadius(15)
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                    UITableView.appearance().backgroundColor = .systemGroupedBackground
                }
        }
    }
    
    func closeScanConfirmationHelpModal() {
        isScanConfirmationHelpOpen = false
    }
}
