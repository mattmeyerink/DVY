//
//  SplitItemModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 2/17/22.
//

import SwiftUI

struct SplitItemModal: View {
    @Binding var currentPage: Pages
    @Binding var isSplitItemModalOpen: Bool
    @Binding var items: [ReciptItem]
    @Binding var itemSplitIndex: Int?
    @Binding var itemExpanded: Int?
    
    @State var splitAssignmentType: Int = 0
    
    init(
        currentPage: Binding<Pages>,
        isSplitItemModalOpen: Binding<Bool>,
        items: Binding<[ReciptItem]>,
        itemSplitIndex: Binding<Int?>,
        itemExpanded: Binding<Int?>
    ) {
        self._currentPage = currentPage
        self._isSplitItemModalOpen = isSplitItemModalOpen
        self._items = items
        self._itemSplitIndex = itemSplitIndex
        self._itemExpanded = itemExpanded
        
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
                }
                
                Text("Item Name: \(items[itemSplitIndex!].name)")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top, 15)
                
                
                if (splitAssignmentType == 0) {
                    ManualSplitForm(
                        items: $items,
                        itemSplitIndex: $itemSplitIndex,
                        closeSplitItemModal: closeSplitItemModal
                    )
                } else {
                    AutomaticSplitForm(
                        closeSplitItemModal: closeSplitItemModal
                    )
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
    
    func closeSplitItemModal() {
        itemExpanded = nil
        isSplitItemModalOpen = false
    }
}
