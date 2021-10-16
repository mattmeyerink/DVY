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
    let priceFormatted: String
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        self.priceFormatted = formatter.string(from: NSNumber(value: price)) ?? "$0"
    }
}

class Person: Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
    let initials: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        
        let firstInitial = String(firstName[firstName.startIndex])
        let lastInitial = String(lastName[lastName.startIndex])
        self.initials = firstInitial + lastInitial
    }
}
