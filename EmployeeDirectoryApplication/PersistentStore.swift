//
//  PersistentStore.swift
//  EmployeeDirectoryApplication
//
//  Created by Andrew on 6/5/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

enum PersistentStoreError: Error {
    case invalidDirectory
    case fileNotExists
    case readingFileError
    case writingFileError
}

protocol PersistentStoring {
    func getData(key: String) -> (Data?, PersistentStoreError?)
    @discardableResult func write(key: String, data: Data) -> PersistentStoreError?
}

class PersistentStore: PersistentStoring {
    
    init() {
        self.fileManager = FileManager.default
    }
    
    func getData(key: String) -> (Data?, PersistentStoreError?) {
        guard let url = getURL(for: key) else {
            return (nil, .invalidDirectory)
        }
        
        guard fileManager.fileExists(atPath: url.path) else {
            return (nil, .fileNotExists)
        }
        
        do {
            let data = try Data(contentsOf: url)
            return (data, nil)
        } catch {
            return (nil, .readingFileError)
        }
    }
    
    @discardableResult func write(key: String, data: Data) -> PersistentStoreError? {
        guard let url = getURL(for: key) else {
            return .invalidDirectory
        }
        
        do {
            try fileManager.createDirectory(atPath: url.absoluteString, withIntermediateDirectories: true, attributes: nil)
            try data.write(to: url, options: [.atomic])
            return nil
        } catch {
            return .writingFileError
        }
    }
    
    private func getURL(for key: String) -> URL? {
        guard let url = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return url.appendingPathComponent(key)
    }
    
    private let fileManager: FileManager
}
