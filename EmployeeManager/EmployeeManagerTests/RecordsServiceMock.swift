//
//  RecordsServiceMock.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/11/22.
//

import Foundation
import RxCocoa
@testable import EmployeeManager

class RecordsServiceMock: RecordsServiceProtocol {
    var areChangesSaved: PublishRelay<Bool> = PublishRelay<Bool>()
    
    //static var employerSample =
    
    func add(employee: Employee) {
        SampleEmployer.data.employees?.append(employee)
    }
    
    func edit(employee: Employee) {
        guard let changedRecord = SampleEmployer.data.employees?.enumerated()
            .first(where: { $0.element.id == employee.id}) else { return }
        
        SampleEmployer.data.employees?[changedRecord.offset] = employee
    }
    
    func delete(employee: Employee) {
        guard let changedRecord = SampleEmployer.data.employees?.enumerated()
            .first(where: { $0.element.id == employee.id}) else { return }
        
        SampleEmployer.data.employees?.remove(at: changedRecord.offset)
    }
}

struct SampleEmployer {
    static var data = Employer(name: "SCP",
                                         employees: [ Employee(name: "Dr. Clef", isEmployed: false, department: "Euclid Containment"),
                                                      Employee(name: "Dr. Bright", isEmployed: true, department: "Keter Containment"),
                                                      Employee(name: "Dr. Ashenworth", isEmployed: true, department: "Thaumaturgical Research"),
                                                      Employee(name: "Dr. Elliot", isEmployed: false, department: "D-Class Management")
                                                    ])
}
