//
//  TaxTipPage.swift
//  DVY
//
//  Created by Matthew Meyerink on 11/25/21.
//

import SwiftUI
import Combine

struct TaxTipPage: View {
    @Binding var currentPage: String
    @Binding var tax: CurrencyObject
    @Binding var tip: CurrencyObject
    
    @State var taxString: String
    @State var isEditingTax = false
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text("Calculate Tax and Tip")
                    .font(.system(size: 30, weight: .semibold))
                    .padding(.vertical, 15)
                    .foregroundColor(Color.white)
                
                if (isEditingTax) {
                    HStack {
                        Text("Tax: ")
                            .font(.system(size: 30, weight: .semibold))
                            .padding(.vertical, 15)
                            .foregroundColor(Color.white)
                        
                        TextField("Tax", text: $taxString)
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .semibold))
                            .keyboardType(.decimalPad)
                            .onReceive(Just(taxString)) { newValue in
                                let filtered = newValue.filter { "0123456789.".contains($0) }
                                if filtered != newValue {
                                    self.taxString = filtered
                                }
                            }
                        
                        Button(action: { saveTax() }) {
                            Text("Save")
                        }
                            .buttonStyle(GreenButton())
                    }
                        .foregroundColor(.white)
                } else {
                    HStack {
                        Text("Tax: " + tax.priceFormatted)
                            .font(.system(size: 30, weight: .semibold))
                            .padding(.vertical, 15)
                            .foregroundColor(Color.white)
                        
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .semibold))
                            .padding(.horizontal, 10)
                            .padding(.bottom, 15)
                            .onTapGesture {
                                self.isEditingTax = true
                            }
                    }
                }
                
            }
        }
        .navigationBarItems(
            leading: Button(action: { self.currentPage = "assignItemsPage" }) {
                Text("< Back").foregroundColor(Color.white)
            }
        )
    }
    
    func saveTax() {
        self.tax = CurrencyObject(price: Double(taxString)!)
        self.isEditingTax = false
    }
}
