//
//  SummaryPage.swift
//  DVY
//
//  Created by Matthew Meyerink on 1/6/22.
//

import SwiftUI

struct SummaryPage: View {
    @Binding var currentPage: String
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text("Summary")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 15)
            }
        }
        .navigationBarItems(
            leading: Button(action: { self.currentPage = "assignItemsPage" }) {
                Text("< Back").foregroundColor(Color.white)
            }
        )
    }
}
