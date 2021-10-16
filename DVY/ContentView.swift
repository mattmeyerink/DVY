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
                LandingPage(isScanning: $isScanning)
            }
            
            if (self.isScanning) {
                NavigationView {
                    ScanConfirmationPage(isScanning: $isScanning)
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
