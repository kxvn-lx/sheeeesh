//
//  File.swift
//  
//
//  Created by Kevin Laminto on 6/4/21.
//

import Foundation

public struct SaveEngine {
    public var savedMemes = [Meme]()
    
    struct SaveData: Codable {
        let savedMemes: [Meme]
    }
    
    private let filePath: URL
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    public init() {
        do {
            filePath = try FileManager.default.url(for: .documentDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: false).appendingPathComponent("SavedDatas")
            
            if let data = try? Data(contentsOf: filePath) {
                decoder.dataDecodingStrategy = .base64
                
                let savedData = try decoder.decode(SaveData.self, from: data)
                self.savedMemes = savedData.savedMemes
            }
        } catch let error {
            fatalError(error.localizedDescription)
            
        }
    }
    
    public mutating func save(_ meme: Meme) {
        if savedMemes.contains(meme) {
            savedMemes.removeAll(where: { $0 == meme })
        } else {
            savedMemes.append(meme)
        }
        
        save()
    }
    
    /**
     This function will delete the cached images stored inside the app.
     */
    public func deleteCacheData() {
        let fileManager = FileManager.default
        let documentsUrl =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first! as NSURL
        let documentsPath = documentsUrl.path

        do {
            if let documentPath = documentsPath {
                let fileNames = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                for fileName in fileNames {
                    if fileName == "com.hackemist.SDImageCache" {
                        let filePathName = "\(documentPath)/\(fileName)"
                        try fileManager.removeItem(atPath: filePathName)
                    }
                }
            }

        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
    
    /**
     This function will delete the stored datas inside the app. (faovurited items, resident, etc)
     */
    public func deleteAppData() {
        let fileManager = FileManager.default
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        let documentsPath = documentsUrl.path

        do {
            if let documentPath = documentsPath {
                let fileNames = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                for fileName in fileNames {
                    if fileName == "SavedDatas" {
                        let filePathName = "\(documentPath)/\(fileName)"
                        try fileManager.removeItem(atPath: filePathName)
                    }
                }
            }

        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
    
    // MARK: - Private methods
    private func save() {
        do {
            let savedData = SaveData(savedMemes: savedMemes)
            let data = try encoder.encode(savedData)
            try data.write(to: filePath, options: .atomicWrite)
        } catch let error {
            print("Error while saving data: \(error.localizedDescription)")
        }
        
        encoder.dataEncodingStrategy = .base64
    }
}
