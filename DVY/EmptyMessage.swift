//
//  EmptyMessage.swift
//  DVY
//
//  Created by Matthew Meyerink on 9/8/22.
//

import SwiftUI

struct EmptyMessage: View {
    @State var firstLine: String
    @State var secondLine: String
    @State var emojis: String
    
    var body: some View {
        VStack {
            Text(firstLine)
                .font(.system(size: 25, weight: .semibold))
                .padding(.vertical, 15)
                .foregroundColor(Color.white)
            
            Text(secondLine)
                .font(.system(size: 25, weight: .semibold))
                .padding(.vertical, 5)
                .foregroundColor(Color.white)
            
            Text(emojis)
                .font(.system(size: 35))
                .padding(.vertical, 5)
        }
    }
}
