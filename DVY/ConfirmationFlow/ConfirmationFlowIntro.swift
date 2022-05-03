//
//  ConfirmationFlowIntro.swift
//  DVY
//
//  Created by Matthew Meyerink on 5/3/22.
//

import SwiftUI

struct ConfirmationFlowIntro: View {
    @Binding var currentFlowState: ConfirmationFlowState
    
    @State var closeConfirmationFlow: () -> Void
    
    var body: some View {
        VStack {
            Text("This will eventually be the intro text for the intitializer")
                .font(.system(size: 20, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .padding(.bottom, 5)
            
            HStack {
                Button (action: { closeConfirmationFlow() } ){
                    Text("Cancel")
                }
                    .buttonStyle(RedButton())
                
                Button (action: { currentFlowState = .form }) {
                    Text("Continue")
                }
                    .buttonStyle(GreenButton())
            }
        }
    }
}
