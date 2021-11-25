//
//  ScanConfirmationPage.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/16/21.
//

import SwiftUI

struct ScanConfirmationPage: View {
    @Binding var currentPage: String
    @Binding var items: [ReciptItem]
    
    @State var itemExpanded: Int? = nil
    @State var isEditModalOpen: Bool = false
    @State var editedItemIndex: Int? = nil
    @State var editedItemName: String = ""
    @State var editedItemPrice: Double = 0.0

    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text("Does this look right?")
                    .font(.system(size: 30, weight: .semibold))
                    .padding(.vertical, 15)
                    .foregroundColor(Color.white)
                
                Button(action: {addItem()}) {
                    Text("Add Item")
                }
                    .buttonStyle(GreenButton())
                    .padding(.bottom, 15)
                
                ScrollView {
                    ForEach(items.indices, id: \.self) { i in
                        VStack {
                            HStack {
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
                                            self.splitItem(splitItemIndex: i)
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
            
        }
        .navigationBarItems(
            leading: Button(action: {self.currentPage = "landingPage"}) {
                Text("< Re-Scan").foregroundColor(Color.white)
            },
            trailing: Button(action: {self.currentPage = "addFriendsPage"}) {
                Text("Next >").foregroundColor(Color.white)
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
    
    func splitItem(splitItemIndex: Int) {
        self.itemExpanded = nil
        items[splitItemIndex].price = items[splitItemIndex].price / 2
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        items[splitItemIndex].priceFormatted = formatter.string(from: NSNumber(value: items[splitItemIndex].price)) ?? "$0"
        
        let newItem = ReciptItem(name: items[splitItemIndex].name, price: items[splitItemIndex].price)
        items.insert(newItem, at: splitItemIndex)
    }
    
    func editItem(editItemIndex: Int) {
        self.itemExpanded = nil
        self.editedItemIndex = editItemIndex
        self.editedItemName = items[editItemIndex].name
        self.editedItemPrice = items[editItemIndex].price
        self.isEditModalOpen = true
    }
    
    func addItem() {
        self.editedItemIndex = nil
        self.editedItemName = ""
        self.editedItemPrice = 0.0
        self.isEditModalOpen = true
    }
    
    func calculateSubtotal() -> CurrencyObject {
        var total = 0.0
        for item in self.items {
            total += item.price
        }
        return CurrencyObject(price: total)
    }
}
