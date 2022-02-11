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
                    Text("Scan Confirmation Page")
                        .font(.system(size: 40, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top, 15)
                    
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 35, weight: .semibold))
                        .onTapGesture() {
                            closeScanConfirmationHelpModal()
                        }
                }
                
                
                Spacer()
                
                VStack {
                    Text("1. Remove all extra items that you do not want to divide between people.")
                        .font(.system(size: 20, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    Text("2. Remove any items indicating a tax or a tip. Tax and tip will be calculated next.")
                        .font(.system(size: 20, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    Text("3. Use the split action divide items that were shared by multiple people.")
                        .font(.system(size: 20, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    Text("4. If the items in the scan are not correct, hit the re-scan button and follow the instructions on that modal to scan the receipt again.")
                        .font(.system(size: 20, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                }
                    .padding(.horizontal, 15)
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
