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
    var employees: PublishSubject<[String]> { get }
}

protocol PersonnelViewModelTypes {
    var inputs: PersonnelViewModelInputs { get }
    var outputs: PersonnelViewModelOutputs { get }
}

class PersonnelViewModel: PersonnelViewModelTypes, PersonnelViewModelInputs, PersonnelViewModelOutputs {
    var inputs: PersonnelViewModelInputs { return self }
    var outputs: PersonnelViewModelOutputs { return self }
    
    var employees: PublishSubject<[String]> = PublishSubject<[String]>()
    
    private let disposeBag = DisposeBag()
    private let coordinator: PersonnelCoordinatorDelegate
    
    init(coordinator: PersonnelCoordinatorDelegate) {
        self.coordinator = coordinator
        
    }
    
    func logout() { }
    func addEmployee() { }
    func setTargetEmployee() { }
    
    func loadEmployees() { }
}
