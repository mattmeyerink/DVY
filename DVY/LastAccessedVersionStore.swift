//
//  LastAccessedVersionStore.swift
//  DVY
//
//  Created by Matthew Meyerink on 11/10/22.
//

import Foundation

class LastAccessedVersionStore: ObservableObject {
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("lastAccessedVersion.data")
    }
    
    static func load(completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileUrl = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileUrl) else {
                    DispatchQueue.main.async {
                        completion(.success(""))
                    }
                    return
                }
                let decodedLastAccessedVersion = try JSONDecoder().decode(String.self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(decodedLastAccessedVersion))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(version: String, completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(version)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(version))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
