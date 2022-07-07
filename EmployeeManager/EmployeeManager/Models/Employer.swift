//
//  Employer.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/7/22.
//

import Foundation

struct Employer {
    var name: String?
    var employees: [Employee]?
}

struct SampleData {
    static let employerSample = Employer(name: "SCP",
                                         employees: [ Employee(name: "Dr. Clef", isEmployed: false),
                                                      Employee(name: "Dr. Bright", isEmployed: true),
                                                      Employee(name: "Dr. Ashenworth", isEmployed: true),
                                                      Employee(name: "Dr. Elliot", isEmployed: false)
                                                    ])
}
