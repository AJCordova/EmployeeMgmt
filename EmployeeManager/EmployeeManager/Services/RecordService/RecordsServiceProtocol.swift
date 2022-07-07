//
//  RecordsServiceProtocol.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/8/22.
//

import Foundation
import RxCocoa

protocol RecordsServiceProtocol {
    func add(employee: Employee)
    func edit(employee: Employee)
    func delete(employee: Employee)
    
    var areChangesSaved: PublishRelay<Bool> { get }
}
