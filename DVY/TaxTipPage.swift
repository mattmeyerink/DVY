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
    @Binding var total: CurrencyObject
    @Binding var items: [ReciptItem]
    
    @State var taxString: String
    @State var isEditingTax = false
    
    @State var selectedTipOption = 1
    @State var isEditingCustomTip = false
    @State var customTipString: String = "0.00"
    @State var customTip: CurrencyObject = CurrencyObject(price: 0.0)
    
    var subtotal: Double

    init(currentPage: Binding<String>, tax: Binding<CurrencyObject>, total: Binding<CurrencyObject>, items: Binding<[ReciptItem]>, taxString: String) {
        self._currentPage = currentPage
        self._tax = tax
        self._total = total
        self._items = items
        self.taxString = taxString
        self.isEditingTax = false
        self.selectedTipOption = 1
        
        self.subtotal = 0.0
        for item in self.items {
            self.subtotal += item.price
        }
        
        let font = UIFont.systemFont(ofSize: 20)
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 0.2, green: 0.9, blue: 0.25, alpha: 1)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white, NSAttributedString.Key.font: font], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black, NSAttributedString.Key.font: font], for: .selected)
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text("TAX")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 15)
                
                if (isEditingTax) {
                    HStack {
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
                        Text(tax.priceFormatted)
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(Color.white)
                            .padding(.trailing, 10)
                            .padding(.vertical, 15)
                        
                        Button(action: { self.isEditingTax = true }) {
                            Text("Edit")
                        }
                            .buttonStyle(GreenButton())
                            .padding(.leading, 10)
                    }
                }
                
                Text("TIP")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(Color.white)
                    .padding(.top, 100)
                
                Picker("What tip would you like to leave", selection: $selectedTipOption) {
                    Text("15%").tag(0)
                    Text("18%").tag(1)
                    Text("20%").tag(2)
                    Text("Custom").tag(3)
                }
                    .pickerStyle(.segmented)
                
                if (selectedTipOption == 3) {
                    if (isEditingCustomTip) {
                        HStack {
                            TextField("Tip", text: $customTipString)
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
                                .onReceive(Just(customTipString)) { newValue in
                                    let filtered = newValue.filter { "0123456789.".contains($0) }
                                    if filtered != newValue {
                                        self.customTipString = filtered
                                    }
                                }
                            
                            Button(action: { saveCustomTip() }) {
                                Text("Save")
                            }
                                .buttonStyle(GreenButton())
                                .padding(.leading, 10)
                        }
                            .foregroundColor(.white)
                    } else {
                        HStack {
                            Text(customTip.priceFormatted)
                                .font(.system(size: 30, weight: .semibold))
                                .foregroundColor(Color.white)
                                .padding(.trailing, 10)
                                .padding(.vertical, 15)
                            
                            Button(action: { self.isEditingCustomTip = true }) {
                                Text("Edit")
                            }
                                .buttonStyle(GreenButton())
                                .padding(.leading, 10)
                        }
                    }
                } else {
                    Text(calculateCurrentTip().priceFormatted)
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(Color.white)
                        .padding(.top, 25)
                }
                
                
                Text("TOTAL: " + calculateCurrentTotal().priceFormatted)
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(Color.white)
                    .padding(.top, 100)
                
                
                ScrollView {}
            }
                .padding(.horizontal)
        }
        .navigationBarItems(
            leading: Button(action: { self.currentPage = "assignItemsPage" }) {
                Text("< Back").foregroundColor(Color.white)
            },
            trailing: Button(action: { nextToFinalPage() }) {
                Text("Next >").foregroundColor(Color.white)
            }
        )
    }
    
    func saveTax() {
        self.tax = CurrencyObject(price: Double(taxString)!)
        self.isEditingTax = false
    }
    
    func getCurrentTipDecimal() -> Double {
        var tipDecimal = 0.0
        if (selectedTipOption == 0) {
            tipDecimal = 0.15
        } else if (selectedTipOption == 1) {
            tipDecimal = 0.18
        } else if (selectedTipOption == 2) {
            tipDecimal = 0.20
        }
        return tipDecimal
    }
    
    func calculateCurrentTip() -> CurrencyObject {
        return CurrencyObject(price: (subtotal + tax.price) * getCurrentTipDecimal())
    }
    
    func calculateCurrentTotal() -> CurrencyObject {
        if (selectedTipOption == 3) {
            return CurrencyObject(price: (subtotal + tax.price + customTip.price))
        }
        
        return CurrencyObject(price: (subtotal + tax.price) * (1 + getCurrentTipDecimal()))
    }
    
    func saveCustomTip() {
        self.customTip = CurrencyObject(price: Double(customTipString)!)
        self.isEditingCustomTip = false
    }
    
    func nextToFinalPage() {
        self.total = calculateCurrentTotal()
        self.currentPage = "summaryPage"
    }
}
