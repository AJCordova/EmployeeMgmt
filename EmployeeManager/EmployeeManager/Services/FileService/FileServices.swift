//
//  FileServices.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/7/22.
//

import Foundation

struct FileServices: FileServicesProtocol {
    
    func employerRecordDirectoryURL() -> URL {
        let folderName = AppDirectories.Records.rawValue
        let documentsFolder = getURL(for: .Documents)
        
        return documentsFolder.appendingPathComponent(folderName)
    }
    
    func createRecordsDirectory() {
        let folderName = AppDirectories.Records.rawValue
        let documentsFolder = getURL(for: .Documents)
        let folderURL = documentsFolder.appendingPathComponent(folderName)
        
        if !exists(file: folderURL) {
            do {
                try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: false)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func doesEmployerFileExist(name: String) -> Bool {
        let recordsFolderURL = getURL(for: .Records)
        var fileURLs: [URL]
        var savedUsers: [String]
        
        do {
            fileURLs = try FileManager.default.contentsOfDirectory(at: recordsFolderURL,
                                                                   includingPropertiesForKeys: nil)
        
        } catch {
            print(error.localizedDescription)
            fileURLs = []
        }
        
        if fileURLs.isEmpty {
            return false
        } else {
            for var url in fileURLs {
                url.hasHiddenExtension = true
            }
            
            savedUsers = fileURLs.map {
                $0.localizedName ?? $0.lastPathComponent
            }
            
            if savedUsers.contains(name) {
                return true
            } else {
                return false
            }
        }
    }
    
    func exists(file at: URL) -> Bool {
        if FileManager.default.fileExists(atPath: at.path) {
            return true
        } else {
            return false
        }
    }
    
    func documentsDirectoryURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func getURL(for directory: AppDirectories) -> URL {
        switch directory {
        case .Documents:
            return documentsDirectoryURL()
        case .Records:
            return employerRecordDirectoryURL()
        }
    }
    
    func saveToJSON(containing: String, to path: AppDirectories, withName name: String) -> Bool {
        let filePath = getURL(for: path).path + "/" + name
        let data: Data? = containing.data(using: .utf8)
        return FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil)
    }
    
    func saveToJSON(employer: Employer) {
        do {
            let data = try JSONEncoder().encode(employer)
            if let jsonString = String(data: data, encoding: .utf8) {
                if saveToJSON(containing: jsonString, to: .Records, withName: employer.name! + ".json") {
                    print(jsonString)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readFromJSON(file at: URL) -> String {
        let fileContents = FileManager.default.contents(atPath: at.path)
        let fileContentsAsString = String(bytes: fileContents!, encoding: .utf8)
        
        if let fileContentsAsString = fileContentsAsString {
            return fileContentsAsString
        }
        
        return ""
    }
}
