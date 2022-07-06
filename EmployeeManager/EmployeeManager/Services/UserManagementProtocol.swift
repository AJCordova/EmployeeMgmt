//
//  UserManagementProtocol.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/7/22.
//

import Foundation
import RxCocoa

protocol UserManagementProtocol {
    var isSigninValid: PublishRelay<Bool> { get }
    var errorMessage: PublishRelay<String> { get }
    var isRegisterSuccessful: PublishRelay<Bool> { get }
    var isEmailAvailable: PublishRelay<Bool> { get }
    
    func checkIfEmailAvailable(email: String)
    func registerUser(email: String, hash: String)
    func userSignin(email: String, hash: String)
}
