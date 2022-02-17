//
//  SplitItemModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 2/17/22.
//

import SwiftUI

struct SplitItemModal: View {
    @Binding var isSplitItemModalOpen: Bool
    
    @State var numberOfPeople: Int = 2
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Split Item")
                        .font(.system(size: 35, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top, 15)
                    
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 35, weight: .semibold))
                        .padding(.top, 15)
                        .onTapGesture() {
                            closeSplitItemModal()
                        }
                }
                    .padding(.horizontal)
                
                Spacer()
                
                Text("Item Name")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top, 15)
                
                Spacer()
                
                Stepper("Number of People: \(numberOfPeople)", value: $numberOfPeople, in: 2...100, step: 1)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
                
                Text("Cost Per Person: $2.00")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .padding(.bottom, 25)
                
                Spacer()
            }
                .frame(width: 350, height: 250, alignment: .center)
                .background(Color(red: 0.1, green: 0.1, blue: 0.1)).cornerRadius(15)
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                    UITableView.appearance().backgroundColor = .systemGroupedBackground
                }
        }
    }
    
    func closeSplitItemModal() {
        isSplitItemModalOpen = false
    }
}
