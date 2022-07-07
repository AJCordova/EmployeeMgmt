//
//  PersonnelCoordinator.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/7/22.
//

import Foundation
import UIKit

protocol PersonnelCoordinatorDelegate: Coordinator {
    func addEmployee(action: RecordEditAction, service: RecordsServiceProtocol)
    func editEmployee(action: RecordEditAction,  employee: Employee, service: RecordsServiceProtocol)
}

final class PersonnelCoordinator: PersonnelCoordinatorDelegate {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = PersonnelViewModel(coordinator: self)
        let viewController = PersonnelViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func addEmployee(action: RecordEditAction, service: RecordsServiceProtocol) {
        navigationController.present(EditRecordViewController(action: action, employee: nil, service: service), animated: true, completion: nil)
    }
    
    func editEmployee(action: RecordEditAction, employee: Employee, service: RecordsServiceProtocol) {
        navigationController.present(EditRecordViewController(action: action, employee: employee, service: service), animated: true, completion: nil)
    }
}
