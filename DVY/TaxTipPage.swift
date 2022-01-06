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
    
    @State var selectedTipOption = 1

    init(currentPage: Binding<String>, tax: Binding<CurrencyObject>, tip: Binding<CurrencyObject>, taxString: String) {
        self._currentPage = currentPage
        self._tax = tax
        self._tip = tip
        self.taxString = taxString
        self.isEditingTax = false
        self.selectedTipOption = 1
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 0.2, green: 0.9, blue: 0.25, alpha: 1)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    }
    
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
                            .foregroundColor(Color.white)
                            .padding(.vertical, 15)
                        
                        TextField("Tax", text: $taxString)
                            .fixedSize()
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .semibold))
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2)
                            )
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
                            .padding(.leading, 10)
                    }
                        .foregroundColor(.white)
                } else {
                    HStack {
                        Text("Tax: " + tax.priceFormatted)
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(Color.white)
                            .padding(.trailing, 10)
                            .padding(.vertical, 15)
                        
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .font(.system(size: 30, weight: .semibold))
                            .onTapGesture {
                                self.isEditingTax = true
                            }
                    }
                }
                
                Picker("What tip would you like to leave", selection: $selectedTipOption) {
                    Text("15%").tag(0)
                    Text("18%").tag(1)
                    Text("20%").tag(2)
                    Text("Custom").tag(3)
                }
                    .pickerStyle(.segmented)
                
                ScrollView {}
            }
                .padding(.horizontal)
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
