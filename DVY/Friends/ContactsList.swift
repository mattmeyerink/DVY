//
//  ContactsList.swift
//  DVY
//
//  Created by Matthew Meyerink on 8/3/22.
//

import SwiftUI

struct ContactsList: View {
    @Binding var contacts: [Contact]
    
    var body: some View {
        Text("Contacts 📖")
            .font(.system(size: 30, weight: .semibold))
            .padding(.vertical, 15)
            .foregroundColor(Color.white)
        
        ScrollView {
            ForEach(contacts.indices, id: \.self) { i in
                VStack {
                    HStack {
                        Text(contacts[i].firstName + " " + contacts[i].lastName)
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.leading, 5)
                        
                        Spacer()
                    }
                }
                    .padding()
                    .background(Color(red: 0.95, green: 0.8, blue: 0.5))
                    .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                    .cornerRadius(10)
            }
        }
    }
}
