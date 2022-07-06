//
//  RegisterCoordinator.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/6/22.
//

import Foundation
import UIKit

protocol RegisterCoordinatorDelegate: Coordinator {
    func gotoSignIn()
}

final class RegisterCoodinator: RegisterCoordinatorDelegate {
    let navigationController : UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = RegisterViewModel(coordinate: self)
        let viewController = RegisterViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func gotoSignIn() {
        let coordinator = SigninCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
}
