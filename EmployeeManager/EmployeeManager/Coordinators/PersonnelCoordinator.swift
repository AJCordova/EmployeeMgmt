//
//  PersonnelCoordinator.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/7/22.
//

import Foundation
import UIKit

protocol PersonnelCoordinatorDelegate: Coordinator {
    func addEmployee()
    func editEmployee()
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
    
    func addEmployee() {}
    func editEmployee() {}
}
