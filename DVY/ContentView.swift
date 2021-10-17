//
//  ContentView.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/15/21.
//

import SwiftUI

struct ContentView: View {
    @State var isConfirmingScan: Bool = false
    @State var isScanning: Bool = false
    @State var recognizedText: String = ""
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            if(!self.isConfirmingScan){
                LandingPage(isScanning: $isScanning, isConfirmingScan: $isConfirmingScan)
            }
            
            if (self.isConfirmingScan) {
                NavigationView {
                    ScanConfirmationPage(isConfirmingScan: $isConfirmingScan)
                }
            }
        }
        .sheet(isPresented: $isScanning) {
            ScanDocumentView(recognizedText: self.$recognizedText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
