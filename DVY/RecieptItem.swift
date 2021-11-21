//
//  RecieptItem.swift
//  DVY
//
//  Created by Matthew Meyerink on 11/4/21.
//

import SwiftUI

struct RecieptItem: View {
    var item: ReciptItem
    
    var body: some View {
        VStack {
            HStack {
                Text(item.name)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.leading, 5)
                
                Spacer()
                
                Text(item.priceFormatted)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.trailing, 5)
            }
        }
            .padding()
            .background(Color(red: 0.95, green: 0.8, blue: 0.5))
            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
            .cornerRadius(10)
    }
}
