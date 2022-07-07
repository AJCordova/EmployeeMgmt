//
//  Employer.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/7/22.
//

import Foundation

struct Employer: Codable {
    var name: String?
    var employees: [Employee]?
}

struct SampleData {
    static let employerSample = Employer(name: "SCP",
                                         employees: [ Employee(name: "Dr. Clef", isEmployed: false, department: "Euclid Containment"),
                                                      Employee(name: "Dr. Bright", isEmployed: true, department: "Keter Containment"),
                                                      Employee(name: "Dr. Ashenworth", isEmployed: true, department: "Thaumaturgical Research"),
                                                      Employee(name: "Dr. Elliot", isEmployed: false, department: "D-Class Management")
                                                    ])
}
