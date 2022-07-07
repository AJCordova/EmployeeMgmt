//
//  Employee.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/7/22.
//

import Foundation

struct Employee: Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    var isEmployed: Bool
    var department: String
}
