//
//  RecordsService.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/8/22.
//

import Foundation
import RxCocoa

struct RecordsService: RecordsServiceProtocol {
    
    var areChangesSaved = PublishRelay<Bool>()
    
    func add(employee: Employee) {
        CurrentEmployer.employer.employees?.append(employee)
        
        let fileService = FileServices()
        fileService.saveToJSON(employer: CurrentEmployer.employer)
        
        self.areChangesSaved.accept(true)
    }
    
    func edit(employee: Employee) {
        guard let changedRecord = CurrentEmployer.employer.employees?.enumerated()
            .first(where: { $0.element.id == employee.id }) else { return }
        
        CurrentEmployer.employer.employees?[changedRecord.offset] = employee
        let fileService = FileServices()
        fileService.saveToJSON(employer: CurrentEmployer.employer)
        
        self.areChangesSaved.accept(true)
    }
    
    func delete(employee: Employee) {
        guard let changedRecord = CurrentEmployer.employer.employees?.enumerated()
            .first(where: { $0.element.id == employee.id }) else { return }
        
        CurrentEmployer.employer.employees?.remove(at: changedRecord.offset)
        let fileService = FileServices()
        fileService.saveToJSON(employer: CurrentEmployer.employer)
        
        self.areChangesSaved.accept(true)
    }
}
