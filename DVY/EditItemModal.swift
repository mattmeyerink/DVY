//
//  EditItemModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/22/21.
//

import SwiftUI

struct EditItemModal: View {
    @Binding var items: [ReciptItem]
    @Binding var showPopup: Bool
    @State var editedItemIndex: Int?
    
    @State var itemName: String
    @State var itemPrice: Double
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            Form {
                Section(header: Text("Name").font(.system(size: 20, weight: .semibold))) {
                    TextField("Name", text: $itemName)
                        .foregroundColor(.black)
                }
                    .foregroundColor(.white)
                
                Section(header: Text("Price").font(.system(size: 20, weight: .semibold))) {
                    TextField("Price", value: $itemPrice, formatter: formatter)
                        .foregroundColor(.black)
                }
                    .foregroundColor(.white)
                
                HStack {
                    Button(action: {self.showPopup = false}) {
                        Text("Cancel")
                    }
                        .buttonStyle(GreenButton())
                    
                    Spacer()
                    
                    Button(action: {self.showPopup = false}) {
                        Text("Save")
                    }
                        .buttonStyle(GreenButton())
                }
                    .listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))
            }
                .frame(width: 350, height: 300, alignment: .center)
                .padding(.top, 15)
                .background(Color(red: 0.1, green: 0.1, blue: 0.1)).cornerRadius(15)
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                    UITableView.appearance().backgroundColor = .systemGroupedBackground
                }
        }
    }
}
