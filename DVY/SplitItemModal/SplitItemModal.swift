//
//  SplitItemModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 2/17/22.
//

import SwiftUI

let manualModalHeight = 350.0
let automaticModalHeight = 500.0

struct SplitItemModal: View {
    @Binding var currentPage: Pages
    @Binding var isSplitItemModalOpen: Bool
    @Binding var items: [ReciptItem]
    @Binding var friends: [Person]
    @Binding var itemSplitIndex: Int?
    @Binding var itemExpanded: Int?
    
    @State var splitAssignmentType: Int
    @State var modalHeight: Double = manualModalHeight
    
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
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Split Item")
                        .font(.system(size: 35, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top, 15)
                    
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 35, weight: .semibold))
                        .padding(.top, 15)
                        .onTapGesture() {
                            closeSplitItemModal()
                        }
                }
                    .padding(.horizontal)
                
                if (currentPage == .assignItemsPage) {
                    Picker("Manual or Automatic Split Assignment", selection: $splitAssignmentType) {
                        Text("Manual").tag(0)
                        Text("Automatic").tag(1)
                    }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        .onChange(of: splitAssignmentType) { _ in
                            updateModalHeight()
                        }
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
                        closeSplitItemModal: closeSplitItemModal,
                        calculateCostPerPerson: calculateCostPerPerson
                    )
                }
                
            }
                .frame(width: 350, height: modalHeight, alignment: .center)
                .background(Color(red: 0.1, green: 0.1, blue: 0.1)).cornerRadius(15)
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                    UITableView.appearance().backgroundColor = .systemGroupedBackground
                }
        }
    }
    
    func closeSplitItemModal() {
        itemExpanded = nil
        isSplitItemModalOpen = false
    }
    
    func updateModalHeight() {
        if (splitAssignmentType == 1) {
            modalHeight = automaticModalHeight
        } else {
            modalHeight = manualModalHeight
        }
    }
    
    func calculateCostPerPerson(peopleCount: Double) -> CurrencyObject {
        let costPerPerson = items[itemSplitIndex!].price / peopleCount
        return CurrencyObject(price: costPerPerson)
    }
}
