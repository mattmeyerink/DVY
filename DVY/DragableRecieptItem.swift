//
//  DragableRecieptItem.swift
//  DVY
//
//  Created by Matthew Meyerink on 11/4/21.
//

import SwiftUI

struct DragableRecieptItem: View {
    var item: ReciptItem
    
    @State var dragAmount = CGSize.zero
    @State var maxWidth = CGFloat.infinity
    
    var body: some View {
        VStack {
            HStack {
                Text(item.name)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.leading, 5)
                
                Spacer()
                
                if (dragAmount == CGSize.zero) {
                    Text(item.priceFormatted)
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.trailing, 5)
                }
            }
                .frame(maxWidth: maxWidth)
        }
            .padding()
            .background(Color(red: 0.95, green: 0.8, blue: 0.5))
            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
            .cornerRadius(10)
            .offset(dragAmount)
            .zIndex(dragAmount == .zero ? 0 : 1)
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged {
                        dragAmount = CGSize(width: $0.translation.width, height: $0.translation.height)
                        maxWidth = 100
                    }
                    .onEnded { _ in
                        dragAmount = .zero
                        maxWidth = .infinity
                    }
            )
    }
}
