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
    @State var items: [ReciptItem]
    
    @State var currentItemIndex: Int = 0
    @State var currentItemName: String = ""
    @State var currentItemPrice: String = ""
    
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
                        closeConfirmationFlow: closeConfirmationFlow,
                        continueToForm: continueToForm
                    )
                }
                
                if (currentFlowState == .form) {
                    ConfirmationFlowForm(
                        items: $items,
                        currentItemIndex: currentItemIndex,
                        currentItemName: currentItemName,
                        currentItemPrice: currentItemPrice,
                        returnToIntro: returnToIntro,
                        continueToSummary: continueToSummary
                    )
                }
                
                if (currentFlowState == .summary) {
                    ConfirmationFlowSummary(
                        items: $items,
                        returnToForm: returnToForm,
                        confirmItemUpdates: confirmItemUpdates
                    )
                }
            }
                .frame(width: 350, height: getModalHeight(), alignment: .center)
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
    
    func continueToForm() {
        resetFormValues(newIndex: 0)
        currentFlowState = .form
    }
    
    func returnToIntro() {
        resetFormValues(newIndex: 0)
        currentFlowState = .intro
    }
    
    func returnToForm() {
        resetFormValues(newIndex: items.count - 1)
        currentFlowState = .form
    }
    
    func continueToSummary() {
        resetFormValues(newIndex: items.count - 1)
        currentFlowState = .summary
    }
    
    func resetFormValues(newIndex: Int) {
        currentItemIndex = newIndex
        currentItemName = items[currentItemIndex].name
        currentItemPrice = items[currentItemIndex].priceFormatted
    }
    
    func confirmItemUpdates() {
        isConfirmationFlowOpen = false
    }
    
    func getModalHeight() -> CGFloat {
        var modalHeight: CGFloat = 0
        
        if (currentFlowState == .intro) {
            modalHeight = 405
        } else if (currentFlowState == .form) {
            modalHeight = 500
        } else if (currentFlowState == .summary) {
            modalHeight = 215
        }
        
        return modalHeight
    }
}
