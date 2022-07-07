//
//  FileServicesProtocol.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/7/22.
//

import Foundation

protocol FileServicesProtocol {
    func documentsDirectoryURL() -> URL
    func employerRecordDirectoryURL() -> URL
    func getURL(for directory: AppDirectories) -> URL
    func createRecordsDirectory()
    func exists(file at: URL) -> Bool
    func doesEmployerFileExist(name: String) -> Bool
    func saveToJSON(containing: String, to path: AppDirectories, withName name: String) -> Bool
    func readFromJSON(file at: URL) -> Employer?
    func retrieveRecords(for employer: String)
}
