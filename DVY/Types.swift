//
//  ReciptItem.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/16/21.
//

import Foundation

class ReciptItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let priceFormatted: String?
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        self.priceFormatted = formatter.string(from: NSNumber(value: price)) ?? "$0"
    }
}
