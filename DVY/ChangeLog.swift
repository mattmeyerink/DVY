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

let v101: DVYVersion = DVYVersion(
    version: "v1.0.1",
    bugFixes: [
        "The percentage being calculated for tips no longer includes the tax."
    ],
    features: []
)

let v110: DVYVersion = DVYVersion(
    version: "v1.1.0",
    bugFixes: [],
    features: [
        "Friends you have added previously are now saved to quickly add later.",
        "Custom color picker to allow any color to be selected for friends.",
        "Scan confirmation flow to allow easy editing of incorrect scans."
    ]
)

let v120: DVYVersion = DVYVersion(
    version: "v1.2.0",
    bugFixes: [
        "Hitting delete button on an item now correctly unassigns the item."
    ],
    features: [
        "DVY can be initiated from a photo.",
        "Add a way to automatically split items amoung everyone or specific friends."
    ]
)

let v130: DVYVersion = DVYVersion(
    version: "v1.3.0",
    bugFixes: [
        "Prevent break when deleting all items in the scan confirmation modal.",
        "Prevent break when saving an item without a price set.",
        "Prevent displaying NaN for tax and tip when a person doesn't have any assigned items."
    ],
    features: [
        "Create friends from contacts.",
        "Add items to the top of the list when they are unassigned.",
        "Add messaging when there are no items, contacts, or friends on the page.",
        "Improved modal usability.",
        "Add delete confirmation for friends and items.",
        "Add fun emojis!"
    ]
)

let dvyVersions: [DVYVersion] = [
    v130,
    v120,
    v110,
    v101
]
