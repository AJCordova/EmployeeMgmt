//
//  SigninViewModel.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/6/22.
//

import RxSwift
import RxCocoa

protocol SigninViewModelInputs {
    func emailDidChange(email: String)
    func passwordDidChange(password: String)
    func signinEmployer(email: String, password: String)
    func registerEmployer()
}

protocol SigninViewModelOutputs {
    var isEmailValid: PublishRelay<TextFieldStatus> { get }
    var isPasswordValid: PublishRelay<TextFieldStatus> { get }
    var invalidEmailMessage: PublishRelay<String> { get }
    var invalidPasswordMessage: PublishRelay<String> { get }
}

protocol SigninViewModelTypes {
    var inputs: SigninViewModelInputs { get }
    var outputs: SigninViewModelOutputs { get }
}

class SigninViewModel: SigninViewModelInputs, SigninViewModelOutputs, SigninViewModelTypes {
    var inputs: SigninViewModelInputs { return self }
    var outputs: SigninViewModelOutputs { return self }
    
    var isEmailValid: PublishRelay<TextFieldStatus> = PublishRelay()
    var isPasswordValid: PublishRelay<TextFieldStatus> = PublishRelay()
    var invalidEmailMessage: PublishRelay<String> = PublishRelay()
    var invalidPasswordMessage: PublishRelay<String> = PublishRelay()
    
    private var disposeBag = DisposeBag()
    private var coordinator: SigninCoordinatorDelegate
    //private var userManager: UserManagementProtocol

    private var emailDidChangeProperty = PublishSubject<String>()
    private var passwordDidChangeProperty = PublishSubject<String>()
    private var shouldProceedToEvents = PublishSubject<Bool>()
    
    init(coordinator: SigninCoordinatorDelegate) {
        self.coordinator = coordinator
        //self.userManager = UserManagementService()
        
        emailDidChangeProperty
            .map { $0.isValidName }
            .bind(to: isEmailValid)
            .disposed(by: disposeBag)
        
        isEmailValid
            .filter { $0 == .invalid }
            .map { _ in "Please enter a registered employer name." }
            .bind(to: invalidEmailMessage)
            .disposed(by: disposeBag)
        
        passwordDidChangeProperty
            .map { $0.count > 7 && $0.count < 21 ? .valid : .invalid }
            .bind(to: isPasswordValid)
            .disposed(by: disposeBag)
        
        isPasswordValid
            .filter { $0 == .invalid }
            .map { _ in "Password has to be from 8 to 20 characters long." }
            .bind(to: invalidPasswordMessage)
            .disposed(by: disposeBag)
        
        isEmailValid
            .filter { $0 == .valid }
            .map { _ in "" }
            .bind(to: invalidEmailMessage)
            .disposed(by: disposeBag)
        
        isPasswordValid
            .filter { $0 == .valid }
            .map { _ in "" }
            .bind(to: invalidPasswordMessage)
            .disposed(by: disposeBag)
        
//        userManager.isSigninValid
//            .bind(to: shouldProceedToEvents)
//            .disposed(by: disposeBag)
        
        shouldProceedToEvents
            .filter { $0 == true }
            .bind(onNext: { _ in
                // self.coordinator.goToEvents()
            })
            .disposed(by: disposeBag)
    }
    
    func emailDidChange(email: String) {
        emailDidChangeProperty.onNext(email)
    }
    
    func passwordDidChange(password: String) {
        passwordDidChangeProperty.onNext(password)
    }
    
    func signinEmployer(email name: String, password: String) {
        print("Sign in tapped")
    }
    
    func registerEmployer() {
        print("Register tapped")
    }
}
