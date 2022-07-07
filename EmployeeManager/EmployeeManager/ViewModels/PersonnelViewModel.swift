//
//  PersonnelViewModel.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/7/22.
//

import Foundation
import RxSwift

protocol PersonnelViewModelInputs {
    func logout()
    func addEmployee()
    func setTargetEmployee()
}

protocol PersonnelViewModelOutputs {
    func loadEmployees()
}

protocol PersonnelViewModelTypes {
    var inputs: PersonnelViewModelInputs { get }
    var outputs: PersonnelViewModelOutputs { get }
}

class PersonnelViewModel: PersonnelViewModelTypes, PersonnelViewModelInputs, PersonnelViewModelOutputs {
    var inputs: PersonnelViewModelInputs { return self }
    var outputs: PersonnelViewModelOutputs { return self }
    
    private let disposeBag = DisposeBag()
    private let coordinator: PersonnelCoordinatorDelegate
    
    init(coordinator: PersonnelCoordinatorDelegate) {
        self.coordinator = coordinator
        loadEmployees()
    }
    
    func logout() { }
    
    func addEmployee() { }
    
    func setTargetEmployee() { }
    
    func loadEmployees() {
    }
}
