//
//  Reactive+Extensions.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/6/22.
//

import UIKit
import RxSwift

extension Reactive where Base: UITextField {
    public var borderColor: Binder<CGColor> {
        return Binder(base, binding: { textField, active in
            textField.layer.borderColor = active
        })
    }
}
