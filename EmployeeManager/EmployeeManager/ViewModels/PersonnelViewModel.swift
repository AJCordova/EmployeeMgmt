//
//  PersonnelViewModel.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/7/22.
//

import Foundation
import RxSwift
import RxRelay

protocol PersonnelViewModelInputs {
    func logout()
    func addEmployee()
    func setTargetEmployee()
}

protocol PersonnelViewModelOutputs {
    var employees: PublishSubject<[Employee]> { get }
    var employer: Employer { get }
}

protocol PersonnelViewModelTypes {
    var inputs: PersonnelViewModelInputs { get }
    var outputs: PersonnelViewModelOutputs { get }
}

class PersonnelViewModel: PersonnelViewModelTypes, PersonnelViewModelInputs, PersonnelViewModelOutputs {
    var inputs: PersonnelViewModelInputs { return self }
    var outputs: PersonnelViewModelOutputs { return self }
    
    var employees: PublishSubject<[Employee]> = PublishSubject<[Employee]>()
    var employer: Employer
    
    private let disposeBag = DisposeBag()
    private let coordinator: PersonnelCoordinatorDelegate
    
    init(coordinator: PersonnelCoordinatorDelegate) {
        self.coordinator = coordinator
        self.employer = SampleData.employerSample
        
        DispatchQueue.main.async {
            self.loadEmployees()
        }
    }
    
    func logout() { }
    
    func addEmployee() { }
    
    func setTargetEmployee() { }
    
    func loadEmployees() {
        guard let employeeList = employer.employees else { return }
        employees.onNext(employeeList)
    }
}
