//
//  VersionUpdateText.swift
//  DVY
//
//  Created by Matthew Meyerink on 11/13/22.
//

import SwiftUI

struct VersionUpdateText: View {
    @State var version: DVYVersion
    
    var body: some View {
        VStack {
            HStack {
                Text("Version " + version.versionTitle)
                    .font(.system(size: 28, weight: .regular))
                    .foregroundColor(Color.white)
                
                Spacer()
            }
            
            if (version.features.count > 0) {
                HStack {
                    Text("New Features")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                }
                    .padding(.vertical, 2)
                
                ForEach(version.features.indices, id: \.self) { i in
                    HStack {
                        Text("- " + version.features[i])
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                    }
                        .padding(.bottom, 2)
                }
            }
            
            if (version.bugFixes.count > 0) {
                HStack {
                    Text("Bugs Fixed")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                }
                    .padding(.vertical, 2)
                
                ForEach(version.bugFixes.indices, id: \.self) { i in
                    HStack {
                        Text("- " + version.bugFixes[i])
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                    }
                        .padding(.bottom, 2)
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}
