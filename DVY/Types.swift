//
//  ReciptItem.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/16/21.
//

import Foundation

class ReciptItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var price: Double
    var priceFormatted: String
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        self.priceFormatted = formatter.string(from: NSNumber(value: price)) ?? "$0"
    }
}

struct Person: Identifiable, Codable {
    var id = UUID()
    
    let firstName: String
    let lastName: String
    let initials: String
    
    let phoneNumber: String
    
    var color: DVYColor
    
    var items: [ReciptItem]
    
    let useCount: Int
    let lastUseDate: Date
    
    
    init(firstName: String, lastName: String, color: Int) {
        self.firstName = firstName
        self.lastName = lastName
        
        let firstInitial = String(firstName[firstName.startIndex])
        var lastInitial = ""
        if (lastName != "") {
            lastInitial = String(lastName[lastName.startIndex])
        }
        
        self.initials = firstInitial + lastInitial
        
        self.phoneNumber = ""
        
        self.color = DVYColors[color]
        
        self.items = []
        
        self.useCount = 1
        self.lastUseDate = Date()
    }
}

class DVYColor: Codable {
    let red: Double
    let green: Double
    let blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

class CurrencyObject {
    let price: Double
    let priceFormatted: String
    
    init(price: Double) {
        self.price = price
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        self.priceFormatted = formatter.string(from: NSNumber(value: price)) ?? "$0"
    }
}

var DVYColors: [DVYColor] = [
    DVYColor(red: 0.95, green: 0.2, blue: 0.2),
    DVYColor(red: 0.95, green: 0.5, blue: 0.2),
    DVYColor(red: 0.95, green: 0.9, blue: 0.2),
    DVYColor(red: 0.2, green: 0.95, blue: 0.85),
    DVYColor(red: 0.2, green: 0.6, blue: 0.95)
]
