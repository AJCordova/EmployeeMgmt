//
//  AppCoordinator.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/6/22.
//

import UIKit
import RxSwift
import RxCocoa

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}

final class AppCoordinator: Coordinator {
    let window: UIWindow
    let navigationController = UINavigationController()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let coordinator = SigninCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
}

