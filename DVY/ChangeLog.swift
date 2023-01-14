//
//  File.swift
//  DVY
//
//  Created by Matthew Meyerink on 11/5/22.
//

import Foundation

let CURRENT_VERSION = "2.0.0"

func getUnseenUpdates(lastSeenVersion: String) -> [DVYVersion] {
    if (lastSeenVersion.isEmpty) {
        return dvyVersions
    }
    
    let lastSeenVersionIncrements = lastSeenVersion.split(separator: ".")
    
    var unseenVersions: [DVYVersion] = []
    
    for version in dvyVersions {
        let versionIncrements = version.versionTitle.split(separator: ".")
        
        for i in 0..<3 {
            let versionNumber = Int(versionIncrements[i])!
            let lastSeenVersionNumber = Int(lastSeenVersionIncrements[i])!
            
            if (versionNumber == lastSeenVersionNumber) {
                continue
            }
            
            if (versionNumber < lastSeenVersionNumber) {
                break
            }
            
            unseenVersions.append(version)
        }
    }
    
    return unseenVersions
}

class DVYVersion {
    let versionTitle: String
    let bugFixes: [String]
    let features: [String]
    
    init(versionTitle: String, bugFixes: [String], features: [String]) {
        self.versionTitle = versionTitle
        self.bugFixes = bugFixes
        self.features = features
    }
}

let v101: DVYVersion = DVYVersion(
    versionTitle: "1.0.1",
    bugFixes: [
        "The percentage being calculated for tips no longer includes the tax."
    ],
    features: []
)

let v110: DVYVersion = DVYVersion(
    versionTitle: "1.1.0",
    bugFixes: [],
    features: [
        "Friends you have added previously are now saved to quickly add later.",
        "Custom color picker to allow any color to be selected for friends.",
        "Scan confirmation flow to allow easy editing of incorrect scans."
    ]
)

let v120: DVYVersion = DVYVersion(
    versionTitle: "1.2.0",
    bugFixes: [
        "Hitting delete button on an item now correctly unassigns the item."
    ],
    features: [
        "DVY can be initiated from a photo.",
        "Add a way to automatically split items among everyone or specific friends."
    ]
)

let v130: DVYVersion = DVYVersion(
    versionTitle: "1.3.0",
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

let v200: DVYVersion = DVYVersion(
    versionTitle: "2.0.0",
    bugFixes: [
        "Fix incorrect numbering on scanning tips list."
    ],
    features: [
        "Overhauled scanning algorithm! Scans should be significantly more accurate. No more cases where a name is matched to the wrong price!",
        "Add a `What's New Modal?` to showcase what has changed since the last time you opened the app."
    ]
)

let v201: DVYVersion = DVYVersion(
    versionTitle: "2.0.1",
    bugFixes: [
        "Fix incorrect coloring on modals containing a text input box."
    ],
    features: []
)

let dvyVersions: [DVYVersion] = [
    v201,
    v200,
    v130,
    v120,
    v110,
    v101
]
