//
//  File.swift
//  DVY
//
//  Created by Matthew Meyerink on 11/5/22.
//

import Foundation

class DVYVersion {
    let version: String
    let bugFixes: [String]
    let features: [String]
    
    init(version: String, bugFixes: [String], features: [String]) {
        self.version = version
        self.bugFixes = bugFixes
        self.features = features
    }
}

let dvyVersions: [String: String] = [:]
