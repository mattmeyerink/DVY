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
    
    var firstName: String
    var lastName: String
    var initials: String
    
    let phoneNumber: String
    
    var color: DVYColor
    
    var items: [ReciptItem]
    
    var useCount: Int
    var lastUseDate: Date
    var previousLastUsedDate: Date?
    
    init(firstName: String, lastName: String, color: DVYColor) {
        self.firstName = firstName
        self.lastName = lastName
        
        self.initials = ""
        
        self.phoneNumber = ""
        
        self.color = color
        
        self.items = []
        
        self.useCount = 1
        self.lastUseDate = Date()
        
        setInitials()
    }
    
    mutating func setInitials() {
        let firstInitial = String(firstName[firstName.startIndex])
        var lastInitial = ""
        if (lastName != "") {
            lastInitial = String(lastName[lastName.startIndex])
        }
        
        self.initials = firstInitial + lastInitial
    }
}

struct Contact: Identifiable, Codable {
    var id = UUID()
    
    var firstName: String
    var lastName: String
    
    var phoneNumber: String
    
    init(firstName: String, lastName: String, phoneNumber: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
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
