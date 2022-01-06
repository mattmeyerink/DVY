//
//  TipSegmentedPicker.swift
//  DVY
//
//  Created by Matthew Meyerink on 1/5/22.
//

import SwiftUI

struct TipSegmentedPicker: View {
    var body: some View {
        Picker("What tip would you like to leave", selection: $selectedTipOption) {
            Text("15%").tag(0)
            Text("18%").tag(1)
            Text("20%").tag(2)
            Text("Custom").tag(3)
        }
            .pickerStyle(.segmented)
    }
}
