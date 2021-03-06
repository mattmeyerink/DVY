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
    @Binding var friends: [Person]
    
    @State var itemExpanded: Int? = nil
    @State var isEditModalOpen: Bool = false
    @State var editedItemIndex: Int? = nil
    @State var editedItemName: String = ""
    @State var editedItemPrice: String = ""
    @State var editModalTitle: String = ""
    
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
                    Button(action: addItem) {
                        Text("Add Item")
                    }
                        .buttonStyle(GreenButton())
                        .padding(.trailing, 5)
                        .padding(.bottom)
                    
                    Button(action: openScanConfirmationModal) {
                        Text("Check Scan")
                    }
                        .buttonStyle(GreenButton())
                        .padding(.bottom)
                }
        
                ScrollView {
                    ForEach(items.indices, id: \.self) { i in
                        VStack {
                            HStack {
                                if (i == itemExpanded) {
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
                            
                            if (i == itemExpanded) {
                                HStack {
                                    Image(systemName: "trash.fill")
                                        .font(.system(size: 25, weight: .semibold))
                                        .padding(.top,  10)
                                        .padding(.horizontal, 10)
                                        .onTapGesture() {
                                            deleteItem(deleteItemIndex: i)
                                        }
                
                                    Image(systemName: "divide.circle.fill")
                                        .font(.system(size: 25, weight: .semibold))
                                        .padding(.top,  10)
                                        .padding(.horizontal, 10)
                                        .onTapGesture() {
                                            openSplitItemModal(index: i)
                                        }
                                    
                                    Image(systemName: "square.and.pencil")
                                        .font(.system(size: 25, weight: .semibold))
                                        .padding(.top,  10)
                                        .padding(.horizontal, 10)
                                        .onTapGesture() {
                                            editItem(editItemIndex: i)
                                        }
                                }
                            }
                        }
                            .padding()
                            .background(Color(red: 0.95, green: 0.8, blue: 0.5))
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                            .cornerRadius(10)
                            .onTapGesture() {
                                toggleExpandedItem(expandedItemIndex: i)
                            }
                    }
                }
                
                HStack {
                    Spacer()
                    
                    Text("???? Subtotal: " + calculateSubtotal().priceFormatted)
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
                    modalTitle: $editModalTitle,
                    editedItemIndex: $editedItemIndex,
                    itemName: $editedItemName,
                    itemPrice: $editedItemPrice
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
                    friends: $friends,
                    itemSplitIndex: $itemSplitIndex,
                    itemExpanded: $itemExpanded,
                    splitAssignmentType: 0
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
            leading: Button(action: openRescanModal) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 15, weight: .bold))
                    
                    Text("Re-Scan")
                        .fontWeight(.bold)
                }
                    .foregroundColor(.white)
            },
            trailing: Button(action: { currentPage = .taxTipPage }) {
                HStack {
                    Text("Next")
                        .fontWeight(.bold)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 15, weight: .bold))
                }
                    .foregroundColor(.white)
            }
        )
    }
    
    func toggleExpandedItem(expandedItemIndex: Int) {
        if (expandedItemIndex == itemExpanded) {
            itemExpanded = nil
        } else {
            itemExpanded = expandedItemIndex
        }
    }
    
    func deleteItem(deleteItemIndex: Int) {
        itemExpanded = nil
        items.remove(at: deleteItemIndex)
    }
    
    func editItem(editItemIndex: Int) {
        itemExpanded = nil
        editModalTitle = "Edit ??????"
        editedItemIndex = editItemIndex
        editedItemName = items[editItemIndex].name
        editedItemPrice = items[editItemIndex].priceFormatted
        isEditModalOpen = true
    }
    
    func addItem() {
        editModalTitle = "Add ????"
        editedItemIndex = nil
        editedItemName = ""
        editedItemPrice = ""
        isEditModalOpen = true
    }
    
    func calculateSubtotal() -> CurrencyObject {
        var total = 0.0
        for item in items {
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
    
    func openScanConfirmationModal() {
        if (items.count > 0) {
            isConfirmationFlowOpen = true
        }
    }
}
