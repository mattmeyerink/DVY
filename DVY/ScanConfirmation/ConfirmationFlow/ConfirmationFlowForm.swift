//
//  ConfirmationFlowForm.swift
//  DVY
//
//  Created by Matthew Meyerink on 5/3/22.
//

import SwiftUI
import Combine

struct ConfirmationFlowForm: View {
    @Binding var items: [ReciptItem]
    
    @State var currentItemIndex: Int
    @State var currentItemName: String
    @State var currentItemPrice: String
    
    @State var returnToIntro: () -> Void
    @State var continueToSummary: () -> Void
    
    var body: some View {
        Form {
            HStack {
                Button(action: deleteCurrentItem) {
                    Text("Delete")
                }
                    .buttonStyle(RedButton())
                
                Spacer()
                
                Button(action: insertNewItem) {
                    Text("Insert")
                }
                    .buttonStyle(GreenButton())
            }
                .listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))
            
            Section(header: Text("Name").font(.system(size: 20, weight: .semibold))) {
                TextField("Name", text: $currentItemName)
                    .foregroundColor(.black)
            }
                .foregroundColor(.white)
            
            Section(header: Text("Price").font(.system(size: 20, weight: .semibold))) {
                TextField("Price", text: $currentItemPrice)
                    .foregroundColor(.black)
                    .keyboardType(.decimalPad)
                    .onReceive(Just(currentItemPrice)) { newValue in
                        DispatchQueue.main.async {
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            if filtered != newValue {
                                currentItemPrice = filtered
                            }
                        }
                    }
            }
                .foregroundColor(.white)
            
            HStack {
                Button(action: goToPreviousItem) {
                    Text("Previous")
                }
                    .buttonStyle(GreenButton())
                
                Spacer()
                
                Button(action: goToNextItem) {
                    Text("Next")
                }
                    .buttonStyle(GreenButton())
            }
                .listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))
        }
    }
    
    func goToPreviousItem() {
        if (currentItemName == "" || currentItemPrice == "") {
            return
        }
        
        items[currentItemIndex] = ReciptItem(name: currentItemName, price: Double(currentItemPrice)!)
        
        if (currentItemIndex == 0) {
            returnToIntro()
        } else {
            currentItemIndex -= 1
            currentItemName = items[currentItemIndex].name
            currentItemPrice = items[currentItemIndex].priceFormatted
        }
    }
    
    func goToNextItem() {
        if (currentItemName == "" || currentItemPrice == "") {
            return
        }

        items[currentItemIndex] = ReciptItem(name: currentItemName, price: Double(currentItemPrice)!)
        
        if (currentItemIndex == items.count - 1) {
            continueToSummary()
        } else {
            currentItemIndex += 1
            currentItemName = items[currentItemIndex].name
            currentItemPrice = items[currentItemIndex].priceFormatted
        }
    }
    
    func deleteCurrentItem() {
        items.remove(at: currentItemIndex)
        
        if (currentItemIndex == items.count) {
            continueToSummary()
        } else {
            currentItemName = items[currentItemIndex].name
            currentItemPrice = items[currentItemIndex].priceFormatted
        }
    }
    
    func insertNewItem() {
        let blankItem = ReciptItem(name: "", price: 0.0)
        items.insert(blankItem, at: currentItemIndex)
        
        currentItemName = items[currentItemIndex].name
        currentItemPrice = items[currentItemIndex].priceFormatted
    }
}
