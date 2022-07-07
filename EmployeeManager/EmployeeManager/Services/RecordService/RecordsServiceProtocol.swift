//
//  RecordsServiceProtocol.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/8/22.
//

import Foundation

protocol RecordsServiceProtocol {
    func add(employee: Employee)
    func edit(employee: Employee)
    func delete(employee: Employee)
}
