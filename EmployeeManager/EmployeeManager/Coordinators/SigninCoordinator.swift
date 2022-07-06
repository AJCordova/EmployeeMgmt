//
//  SigninCoordinator.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/6/22.
//

import UIKit

protocol SigninCoordinatorDelegate: Coordinator {
    func goToCreateNewEmployerView()
    func goToEmployeeManagementView()
}

final class SigninCoordinator: SigninCoordinatorDelegate {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SigninViewModel(coordinator: self)
        let viewController = SigninViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToEmployeeManagementView() {
        //
    }
    
    func goToCreateNewEmployerView() {
        let coordinator = RegisterCoodinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
}
