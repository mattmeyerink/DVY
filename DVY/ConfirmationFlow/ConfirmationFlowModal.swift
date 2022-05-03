//
//  ConfirmationFlowModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 5/3/22.
//

import SwiftUI

enum ConfirmationFlowState {
    case intro
    case form
    case summary
}

struct ConfirmationFlowModal: View {
    @Binding var isConfirmationFlowOpen: Bool
    
    @State var currentFlowState = ConfirmationFlowState.intro
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Confirm Items")
                        .font(.system(size: 35, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top, 15)
                    
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 35, weight: .semibold))
                        .padding(.top, 15)
                        .onTapGesture() {
                            closeConfirmationFlow()
                        }
                }
                    .padding(.horizontal)
                
                Spacer()
                
                if (currentFlowState == .intro) {
                    ConfirmationFlowIntro(
                        currentFlowState: $currentFlowState,
                        closeConfirmationFlow: closeConfirmationFlow
                    )
                }
                
                if (currentFlowState == .form) {
                    ConfirmationFlowForm()
                }
                
                if (currentFlowState == .summary) {
                    ConfirmationFlowSummary()
                }
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
    
    func closeConfirmationFlow() {
        isConfirmationFlowOpen = false
        currentFlowState = .intro
    }
}
