//
//  String+Extensions.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/6/22.
//

import Foundation

extension String {
    var isValidEmail: TextFieldStatus {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self) ? .valid : .invalid
    }
    
    //Encoding to protect raw password string
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
}
