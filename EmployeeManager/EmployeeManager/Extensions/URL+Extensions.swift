//
//  URL+Extensions.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/7/22.
//

import Foundation

extension URL {
    var localizedName: String? { (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName }
    
    var hasHiddenExtension: Bool {
        get {
            (try? resourceValues(forKeys: [.hasHiddenExtensionKey]))?.hasHiddenExtension == true
        }
        set {
            var resourceValues = URLResourceValues()
            resourceValues.hasHiddenExtension = newValue
            try? setResourceValues(resourceValues)
        }
    }
}
