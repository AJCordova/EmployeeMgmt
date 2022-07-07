//
//  Constants.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/7/22.
//

import Foundation

struct Constants {
    static let collectionReference = "Employers"
    static let fieldReference = "email"
}

enum AppDirectories: String {
    case Documents = "Documents"
    case Records = "EmployeeRecords"
}

enum RecordEditAction {
    case add, edit
}
