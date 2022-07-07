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
    func editEmployee(employee: Employee)
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
    private let fileServices: FileServicesProtocol
    private let recordServices: RecordsServiceProtocol
    
    init(coordinator: PersonnelCoordinatorDelegate) {
        self.coordinator = coordinator
        self.employer = CurrentEmployer.employer
        self.fileServices = FileServices()
        self.recordServices = RecordsService()
        
        self.retrieveEmployeeList()
        
        recordServices.areChangesSaved
            .filter { $0 == true }
            .bind(onNext: { _ in
                DispatchQueue.main.async {
                    self.retrieveEmployeeList()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func logout() {
        CurrentEmployer.employer = Employer()
        coordinator.goToSign()
    }
    
    func addEmployee() {
        coordinator.addEmployee(action: .add, service: recordServices)
    }
    
    func editEmployee(employee: Employee) {
        coordinator.editEmployee(action: .edit, employee: employee, service: recordServices)
    }
    
    func loadEmployees() {
        guard let employeeList = CurrentEmployer.employer.employees else { return }
        employees.onNext(employeeList)
    }
    
    private func retrieveEmployeeList() {
        if fileServices.doesEmployerFileExist(name: employer.name!) {
            fileServices.retrieveRecords(for: employer.name!)
        } else {
            fileServices.createRecordsDirectory()
        }
        
        DispatchQueue.main.async {
            self.loadEmployees()
        }
    }
}
