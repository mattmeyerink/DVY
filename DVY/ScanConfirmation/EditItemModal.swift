//
//  EditItemModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/22/21.
//

import SwiftUI
import Combine

struct EditItemModal: View {
    @Binding var items: [ReciptItem]
    @Binding var showPopup: Bool
    @State var editedItemIndex: Int?
    
    @State var itemName: String
    @State var itemPrice: String
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var body: some View {
        Modal (
            isOpen: $showPopup,
            closeModal: closePopup,
            modalHeight: 450,
            modalTitle: "Edit/Add"
        ) {
            Form {
                Section(header: Text("Name").font(.system(size: 20, weight: .semibold))) {
                    TextField("Name", text: $itemName)
                        .foregroundColor(.black)
                }
                    .foregroundColor(.white)
                
                Section(header: Text("Price").font(.system(size: 20, weight: .semibold))) {
                    TextField("Price", text: $itemPrice)
                        .foregroundColor(.black)
                        .keyboardType(.decimalPad)
                        .onReceive(Just(itemPrice)) { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            if filtered != newValue {
                                self.itemPrice = filtered
                            }
                        }
                }
                    .foregroundColor(.white)
                
                HStack {
                    Button(action: closePopup) {
                        Text("Cancel")
                    }
                        .buttonStyle(RedButton())
                    
                    Spacer()
                    
                    Button(action: saveItem) {
                        Text("Save")
                    }
                        .buttonStyle(GreenButton())
                }
                    .listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))
            }
        }
    }
    
    func saveItem() {
        if (itemName == "") {
            return
        }
        
        if (editedItemIndex != nil) {
            items[editedItemIndex!] = ReciptItem(name: itemName, price: Double(self.itemPrice)!)
        } else {
            items.append(ReciptItem(name: itemName, price: Double(self.itemPrice)!))
        }
        
        closePopup()
    }
    
    func closePopup() {
        showPopup = false
    }
}
