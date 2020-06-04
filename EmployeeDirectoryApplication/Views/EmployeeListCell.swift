//
//  EmployeeListCell.swift
//  EmployeeDirectoryApplication
//
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

class EmployeeListCell: UITableViewCell {
    static let identifier = "EmployeeListCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 20, y: 2.5, width: 55, height: 55);
    }
}
