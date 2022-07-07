//
//  EmployeeTableViewCell.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/7/22.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var statusIndicator: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .cyan
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
