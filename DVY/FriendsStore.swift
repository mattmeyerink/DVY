//
//  FriendsStore.swift
//  DVY
//
//  Created by Matthew Meyerink on 4/13/22.
//

import Foundation
import SwiftUI

class FriendsStore: ObservableObject {
    @Published var previouslyAddedFriends: [Person] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("previouslyAddedFriends.data")
    }
    
    static func load(completion: @escaping (Result<[Person], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileUrl = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileUrl) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let decodedFriends = try JSONDecoder().decode([Person].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(decodedFriends))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(friends: [Person], completion: @escaping (Result<[Person], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(friends)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(friends))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
