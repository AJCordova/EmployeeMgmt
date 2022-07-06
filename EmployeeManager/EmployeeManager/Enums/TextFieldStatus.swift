//
//  TextFieldStatus.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/6/22.
//

import Foundation
import UIKit

enum TextFieldStatus {
    case valid, invalid
    
    var borderColor: CGColor {
        switch self {
        case .valid: return UIColor.lightGray.cgColor
        default:
            return UIColor.systemRed.cgColor
        }
    }
    
    var isValid: Bool {
        switch self {
        case .valid: return true
        default:
            return false
        }
    }
}
