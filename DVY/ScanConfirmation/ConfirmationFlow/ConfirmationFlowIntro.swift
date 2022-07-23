//
//  ConfirmationFlowIntro.swift
//  DVY
//
//  Created by Matthew Meyerink on 5/3/22.
//

import SwiftUI

struct ConfirmationFlowIntro: View {
    @State var closeConfirmationFlow: () -> Void
    @State var continueToForm: () -> Void
    
    var body: some View {
        VStack {
            Group {
                Text("This is a flow to correct the items scanned from the receipt.")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                Spacer()
                
                Text("Items from the receipt will be displayed in order.")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }
        
            Spacer()
            
            Group {
                Text("At each item you can...")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                Spacer()
                
                Text("1. Edit the price/name of the current item.")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                Spacer()
                
                Text("2. Insert an item if one was missed.")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                Spacer()
                
                Text("3. Delete an item if it is not needed.")
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }
            
            Spacer()
            
            HStack {
                Button (action: { closeConfirmationFlow() } ){
                    Text("Cancel")
                }
                    .buttonStyle(RedButton())
                
                Spacer()
                
                Button (action: { continueToForm() }) {
                    Text("Continue")
                }
                    .buttonStyle(GreenButton())
            }
                .padding(.bottom)
                .padding(.horizontal)
        }
    }
}
