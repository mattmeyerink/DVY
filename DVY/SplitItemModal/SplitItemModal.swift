//
//  SplitItemModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 2/17/22.
//

import SwiftUI

let manualModalHeight = 350
let automaticModalHeight = 550

struct SplitItemModal: View {
    @Binding var currentPage: Pages
    @Binding var isSplitItemModalOpen: Bool
    @Binding var items: [ReciptItem]
    @Binding var friends: [Person]
    @Binding var itemSplitIndex: Int?
    @Binding var itemExpanded: Int?
    
    @State var splitAssignmentType: Int
    @State var applyToAll: Bool = false
    @State var modalTitle: String = "Split ✂️"
    @State var otherModalOpening: Bool = false
    
    init(
        currentPage: Binding<Pages>,
        isSplitItemModalOpen: Binding<Bool>,
        items: Binding<[ReciptItem]>,
        friends: Binding<[Person]>,
        itemSplitIndex: Binding<Int?>,
        itemExpanded: Binding<Int?>,
        splitAssignmentType: Int
    ) {
        self._currentPage = currentPage
        self._isSplitItemModalOpen = isSplitItemModalOpen
        self._items = items
        self._friends = friends
        self._itemSplitIndex = itemSplitIndex
        self._itemExpanded = itemExpanded
        self.splitAssignmentType = splitAssignmentType
        
        let font = UIFont.systemFont(ofSize: 20)
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 0.2, green: 0.9, blue: 0.25, alpha: 1)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white, NSAttributedString.Key.font: font], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black, NSAttributedString.Key.font: font], for: .selected)
    }
    
    var body: some View {
        Modal(
            modalTitle: $modalTitle,
            otherModalOpening: $otherModalOpening,
            closeModal: closeSplitItemModal,
            modalHeight: getModalHeight()
        ) {
            if (currentPage == .assignItemsPage) {
                Picker("Manual or Automatic Split Assignment", selection: $splitAssignmentType) {
                    Text("Manual").tag(0)
                    Text("Automatic").tag(1)
                }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
            }
            
            Text("Item Name: \(items[itemSplitIndex!].name)")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
                .padding(.top, 15)
            
            
            if (splitAssignmentType == 0) {
                ManualSplitForm(
                    items: $items,
                    itemSplitIndex: $itemSplitIndex,
                    closeSplitItemModal: closeSplitItemModal,
                    calculateCostPerPerson: calculateCostPerPerson
                )
            } else {
                AutomaticSplitForm(
                    friends: $friends,
                    items: $items,
                    itemSplitIndex: $itemSplitIndex,
                    applyToAll: $applyToAll,
                    closeSplitItemModal: closeSplitItemModal,
                    calculateCostPerPerson: calculateCostPerPerson
                )
            }
        }
    }
    
    func closeSplitItemModal() {
        itemExpanded = nil
        isSplitItemModalOpen = false
    }
    
    func calculateCostPerPerson(peopleCount: Double) -> CurrencyObject {
        let costPerPerson = items[itemSplitIndex!].price / peopleCount
        return CurrencyObject(price: costPerPerson)
    }
    
    func getModalHeight() -> Int {
        let modalHeight: Int
        
        if (splitAssignmentType == 0 || applyToAll) {
            modalHeight = manualModalHeight
        } else {
            modalHeight = automaticModalHeight
        }
        
        return modalHeight
    }
}
