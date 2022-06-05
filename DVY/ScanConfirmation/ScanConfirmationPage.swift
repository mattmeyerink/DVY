//
//  ScanConfirmationPage.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/16/21.
//

import SwiftUI

struct ScanConfirmationPage: View {
    @Binding var currentPage: Pages
    @Binding var items: [ReciptItem]
    
    @State var itemExpanded: Int? = nil
    @State var isEditModalOpen: Bool = false
    @State var editedItemIndex: Int? = nil
    @State var editedItemName: String = ""
    @State var editedItemPrice: String = ""
    
    @State var isRescanModalOpen: Bool = false
    @State var isScanConfirmationHelpOpen: Bool = false
    @State var isSplitItemModalOpen: Bool = false
    @State var isConfirmationFlowOpen: Bool = false
    
    @State var itemSplitIndex: Int? = nil

    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                HStack {
                    Text("Confirm Items")
                        .font(.system(size: 30, weight: .semibold))
                        .padding(.vertical, 15)
                        .foregroundColor(Color.white)
                    
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 23, weight: .semibold))
                        .padding(.leading, 2)
                        .onTapGesture() {
                            openScanConfirmationHelpModal()
                        }
                }
               
                HStack {
                    Button(action: { addItem() }) {
                        Text("Add Item")
                    }
                        .buttonStyle(GreenButton())
                        .padding(.trailing, 5)
                        .padding(.bottom)
                    
                    Button(action: { isConfirmationFlowOpen = true }) {
                        Text("Check Scan")
                    }
                        .buttonStyle(GreenButton())
                        .padding(.bottom)
                }
        
                ScrollView {
                    ForEach(items.indices, id: \.self) { i in
                        VStack {
                            HStack {
                                if (i == self.itemExpanded) {
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 18, weight: .heavy))
                                } else {
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 18, weight: .heavy))
                                }
                                
                                Text(items[i].name)
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.leading, 5)
                                
                                Spacer()
                                
                                Text(items[i].priceFormatted)
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.trailing, 5)
                            }
                            
                            if (i == self.itemExpanded) {
                                HStack {
                                    Image(systemName: "trash.fill")
                                        .font(.system(size: 25, weight: .semibold))
                                        .padding(.top,  10)
                                        .padding(.horizontal, 10)
                                        .onTapGesture() {
                                            self.deleteItem(deleteItemIndex: i)
                                        }
                
                                    Image(systemName: "divide.circle.fill")
                                        .font(.system(size: 25, weight: .semibold))
                                        .padding(.top,  10)
                                        .padding(.horizontal, 10)
                                        .onTapGesture() {
                                            self.openSplitItemModal(index: i)
                                        }
                                    
                                    Image(systemName: "square.and.pencil")
                                        .font(.system(size: 25, weight: .semibold))
                                        .padding(.top,  10)
                                        .padding(.horizontal, 10)
                                        .onTapGesture() {
                                            self.editItem(editItemIndex: i)
                                        }
                                }
                            }
                        }
                            .padding()
                            .background(Color(red: 0.95, green: 0.8, blue: 0.5))
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                            .cornerRadius(10)
                            .onTapGesture() {
                                self.toggleExpandedItem(expandedItemIndex: i)
                            }
                    }
                }
                
                HStack {
                    Spacer()
                    
                    Text("Subtotal: " + calculateSubtotal().priceFormatted)
                        .font(.system(size: 25, weight: .semibold))
                }
                    .foregroundColor(Color.white)
                    .padding(.vertical)
                    .padding(.horizontal)
            }
                .padding(.horizontal)
            
            if (isEditModalOpen) {
                EditItemModal(
                    items: $items,
                    showPopup: $isEditModalOpen,
                    editedItemIndex: editedItemIndex,
                    itemName: editedItemName,
                    itemPrice: editedItemPrice
                )
            }
            
            if (isRescanModalOpen) {
                RescanConfirmationModal(currentPage: $currentPage, isRescanModalOpen: $isRescanModalOpen)
            }
            
            if (isScanConfirmationHelpOpen) {
                ScanConfirmationHelpModal(isScanConfirmationHelpOpen: $isScanConfirmationHelpOpen)
            }
            
            if (isSplitItemModalOpen) {
                SplitItemModal(
                    currentPage: $currentPage,
                    isSplitItemModalOpen: $isSplitItemModalOpen,
                    items: $items,
                    itemSplitIndex: $itemSplitIndex,
                    itemExpanded: $itemExpanded
                )
            }
            
            if (isConfirmationFlowOpen) {
                ConfirmationFlowModal(
                    isConfirmationFlowOpen: $isConfirmationFlowOpen,
                    items: items,
                    saveUpdatedItems: saveUpdatedItems
                )
            }
            
        }
        .navigationBarItems(
            leading: Button(action: { openRescanModal() }) {
                Text("< Re-Scan")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            },
            trailing: Button(action: { self.currentPage = .taxTipPage }) {
                Text("Next >")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
        )
    }
    
    func toggleExpandedItem(expandedItemIndex: Int) {
        if (expandedItemIndex == self.itemExpanded) {
            self.itemExpanded = nil
        } else {
            self.itemExpanded = expandedItemIndex
        }
    }
    
    func deleteItem(deleteItemIndex: Int) {
        self.itemExpanded = nil
        items.remove(at: deleteItemIndex)
    }
    
    func editItem(editItemIndex: Int) {
        self.itemExpanded = nil
        self.editedItemIndex = editItemIndex
        self.editedItemName = items[editItemIndex].name
        self.editedItemPrice = items[editItemIndex].priceFormatted
        self.isEditModalOpen = true
    }
    
    func addItem() {
        self.editedItemIndex = nil
        self.editedItemName = ""
        self.editedItemPrice = ""
        self.isEditModalOpen = true
    }
    
    func calculateSubtotal() -> CurrencyObject {
        var total = 0.0
        for item in self.items {
            total += item.price
        }
        return CurrencyObject(price: total)
    }
    
    func openRescanModal() {
        isRescanModalOpen = true
    }
    
    func openScanConfirmationHelpModal() {
        isScanConfirmationHelpOpen = true
    }
    
    func openSplitItemModal(index: Int) {
        itemSplitIndex = index
        isSplitItemModalOpen = true
    }
    
    func saveUpdatedItems(updatedItems: [ReciptItem]) {
        items = updatedItems
    }
}
