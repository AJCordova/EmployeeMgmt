//
//  RecordsService.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/8/22.
//

import Foundation

struct RecordsService: RecordsServiceProtocol {
    
    func add(employee: Employee) {
        guard var employees = CurrentEmployer.employer.employees else { return }
        employees.append(employee)
        
        CurrentEmployer.employer.employees = employees
        let fileService = FileServices()
        fileService.saveToJSON(employer: CurrentEmployer.employer)
        
        // emit to reload from JSON
    }
    
    func edit(employee: Employee) {
        guard let changedRecord = CurrentEmployer.employer.employees?.enumerated()
            .first(where: { $0.element.id == employee.id }) else { return }
        
        CurrentEmployer.employer.employees?[changedRecord.offset] = employee
        let fileService = FileServices()
        fileService.saveToJSON(employer: CurrentEmployer.employer)
        
        // emit to reload from JSON
    }
    
    func delete(employee: Employee) {
        guard let changedRecord = CurrentEmployer.employer.employees?.enumerated()
            .first(where: { $0.element.id == employee.id }) else { return }
        
        CurrentEmployer.employer.employees?.remove(at: changedRecord.offset)
        let fileService = FileServices()
        fileService.saveToJSON(employer: CurrentEmployer.employer)
        
        // emit to reload from JSON
    }
    
    
}
