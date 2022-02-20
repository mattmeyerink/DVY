//
//  SplitItemModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 2/17/22.
//

import SwiftUI

struct SplitItemModal: View {
    @Binding var isSplitItemModalOpen: Bool
    @Binding var items: [ReciptItem]
    @Binding var itemSplitIndex: Int?
    @Binding var itemExpanded: Int?
    
    @State var numberOfPeople: Int = 2
    
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
                
                Spacer()
                
                Text(items[itemSplitIndex!].name)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top, 15)
                
                Spacer()
                
                Stepper("Number of People: \(numberOfPeople)", value: $numberOfPeople, in: 2...100, step: 1)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
                
                Text("Cost Per Person: \(calculateCostPerPerson().priceFormatted)")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
                
                HStack {
                    Button(action: { closeSplitItemModal() }) {
                        Text("Cancel")
                    }
                        .buttonStyle(GreenButton())
                    
                    Spacer()
                    
                    Button(action: { splitItem() }) {
                        Text("Split")
                    }
                        .buttonStyle(GreenButton())
                }
                    .padding()
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
    
    func splitItem() {
        closeSplitItemModal()
        items[itemSplitIndex!].price = calculateCostPerPerson().price
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        items[itemSplitIndex!].priceFormatted = formatter.string(from: NSNumber(value: items[itemSplitIndex!].price)) ?? "$0"
        
        for _ in 0...(numberOfPeople - 2) {
            let newItem = ReciptItem(name: items[itemSplitIndex!].name, price: items[itemSplitIndex!].price)
            items.insert(newItem, at: itemSplitIndex!)
        }
    }
       
    func calculateCostPerPerson() -> CurrencyObject {
        let costPerPerson = items[itemSplitIndex!].price / Double(numberOfPeople)
        return CurrencyObject(price: costPerPerson)
    }
}
