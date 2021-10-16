//
//  ContentView.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/15/21.
//

import SwiftUI

struct ContentView: View {
    @State var isScanning: Bool = false
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            if(!self.isScanning){
                VStack() {
                    Text("Welcome to DVY")
                        .font(.system(size: 45, weight: .semibold))
                        .foregroundColor(Color.white)
                        .padding(.bottom, 10)
                    
                    Text("Scan a recipt to start")
                        .font(.system(size: 30))
                        .foregroundColor(Color.white)
                        .padding(.bottom, 10)
                    
                    Button(action: {self.isScanning = true}) {
                        Text("Scan")
                    }
                        .buttonStyle(GreenButton())
                }
            }
            
            if (self.isScanning) {
                NavigationView {
                    ScanConfirmationPage()
                }
            }
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GreenButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 25, weight: .bold))
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
            .background(Color(red: 0.2, green: 0.9, blue: 0.25))
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ScanConfirmationPage: View {
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text("Does this look right?")
                    .font(.system(size: 30, weight: .semibold))
                    .padding(.vertical, 15)
                    .foregroundColor(Color.white)
                
                ScrollView {
                    HStack {
                        Text("Pizza")
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.leading, 5)
                        Spacer()
                        Text("$5.00")
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.trailing, 5)
                    }
                        .padding()
                        .background(Color(red: 0.95, green: 0.8, blue: 0.5))
                        .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                        .cornerRadius(10)
                    
                    HStack {
                        Text("Burger")
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.leading, 5)
                        Spacer()
                        Text("$2.00")
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.trailing, 5)
                    }
                        .padding()
                        .background(Color(red: 0.95, green: 0.8, blue: 0.5))
                        .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                        .cornerRadius(10)
                    
                    HStack {
                        Text("Oberon")
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.leading, 5)
                        Spacer()
                        Text("$1.50")
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.trailing, 5)
                    }
                        .padding()
                        .background(Color(red: 0.95, green: 0.8, blue: 0.5))
                        .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                        .cornerRadius(10)
                }
                
                HStack {
                    Text("Tax: $1.00")
                        .font(.system(size: 25, weight: .semibold))
                    Spacer()
                    Text("Total: $8.50")
                        .font(.system(size: 25, weight: .semibold))
                }
                    .foregroundColor(Color.white)
                    .padding(.vertical)
                .padding(.horizontal)
            }
                .padding(.horizontal)
        }
        .navigationBarItems(trailing: Text("Next").foregroundColor(Color.white))
    }
}
