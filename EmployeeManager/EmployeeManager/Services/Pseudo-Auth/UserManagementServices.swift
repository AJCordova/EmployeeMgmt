//
//  UserManagementServices.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/7/22.
//

import Foundation
import RxCocoa
import FirebaseFirestore

struct UserManagementServices: UserManagementProtocol {
    var isEmailAvailable: PublishRelay<Bool> = PublishRelay<Bool>()
    var isSigninValid = PublishRelay<Bool>()
    var errorMessage = PublishRelay<String>()
    var isRegisterSuccessful = PublishRelay<Bool>()
    
    private static var db = Firestore.firestore()
    private var reference: CollectionReference? = db.collection(Constants.collectionReference)
}

extension UserManagementServices {
    func userSignin(email: String, hash: String) {
        reference?.whereField(Constants.fieldReference, isEqualTo: email).getDocuments() { (snapshot, error) in
            if let err = error {
                print("Error: \(err.localizedDescription)")
                self.errorMessage.accept("Login Error")
            } else {
                if snapshot?.documents.count == 1 {
                    guard let document = snapshot?.documents.first else { return }
                    let data = document.data()
                    if hash.elementsEqual((data["password"] as? String)!) {
                        setCurrentUser(email: email)
                        self.isSigninValid.accept(true)
                    } else {
                        self.isSigninValid.accept(false)
                    }
                } else {
                    self.isSigninValid.accept(false)
                }
            }
        }
    }
    
    func registerUser(email: String, hash: String) {
        var docReference: DocumentReference? = nil
        docReference = reference?.addDocument(data: ["email": email, "password": hash]) { error in
            if let error = error {
                self.errorMessage.accept("Register Error")
                print("Error: \(error.localizedDescription)")
            }
            
            if let _ = docReference?.documentID {
                self.isRegisterSuccessful.accept(true)
            } else {
                self.isRegisterSuccessful.accept(false)
            }
        }
    }
    
    func checkIfEmailAvailable(email: String) {
        reference?.whereField(Constants.fieldReference, isEqualTo: email).getDocuments() { (snapshot, error) in
            if let err = error {
                print("Error: \(err)")
            } else {
                if snapshot!.isEmpty {
                    self.isEmailAvailable.accept(true)
                } else {
                    self.isEmailAvailable.accept(false)
                }
            }
        }
    }
    
    private func setCurrentUser(email: String) {
        let delimiter = "@"
        let newstr = email
        let token = newstr.components(separatedBy: delimiter)
        let name = token[0]
        print(name)
        
        CurrentEmployer.employer = Employer(name: name, employees: [])
    }
}
