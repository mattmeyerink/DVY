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
    
    @State var saveUpdatedItems: ([ReciptItem]) -> Void
    
    @State var currentItemIndex: Int = 0
    @State var currentItemName: String = ""
    @State var currentItemPrice: String = ""
    
    @State var modalTitle: String = "Confirm 🍔"
    @State var otherModalOpening: Bool = false
    
    var body: some View {
        Modal(
            modalTitle: $modalTitle,
            otherModalOpening: $otherModalOpening,
            closeModal: closeConfirmationFlow,
            modalHeight: getModalHeight()
        ) {
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
        if (items.count > 0) {
            resetFormValues(newIndex: items.count - 1)
            currentFlowState = .form
        } else {
         closeConfirmationFlow()
        }
    }
    
    func continueToSummary() {
        resetFormValues(newIndex: items.count - 1)
        currentFlowState = .summary
    }
    
    func resetFormValues(newIndex: Int) {
        currentItemIndex = newIndex
        if (items.count > 0) {
            currentItemName = items[currentItemIndex].name
            currentItemPrice = items[currentItemIndex].priceFormatted
        }
    }
    
    func confirmItemUpdates() {
        saveUpdatedItems(items)
        closeConfirmationFlow()
    }
    
    func getModalHeight() -> Int {
        var modalHeight = 0
        
        if (currentFlowState == .intro) {
            modalHeight = 500
        } else if (currentFlowState == .form) {
            modalHeight = 550
        } else if (currentFlowState == .summary) {
            modalHeight = 275
        }
        
        return modalHeight
    }
}
