//
//  AutomaticSplitForm.swift
//  DVY
//
//  Created by Matthew Meyerink on 6/3/22.
//

import SwiftUI

struct AutomaticSplitForm: View {
    @Binding var friends: [Person]
    
    @State var closeSplitItemModal: () -> Void
    
    var body: some View {
        Text("This will be the automatic split form!")
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(.white)
            .padding(.top, 15)
        
        ForEach(friends.indices, id: \.self) { i in
            HStack {
                Text(friends[i].firstName + " " + friends[i].lastName)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.leading, 5)
                
                Spacer()
                
                Text(String(friends[i].items.count) + " Item(s)")
            }
                .padding()
                .background(Color(red: friends[i].color.red, green: friends[i].color.green, blue: friends[i].color.blue))
                .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                .cornerRadius(10)
        }
        
        SplitModalButtons(
            cancelAction: closeSplitItemModal,
            splitItemAction: closeSplitItemModal
        )
    }
}
