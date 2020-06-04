//
//  FullScreenView.swift
//  EmployeeDirectoryApplication
//
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

class FullScreenView: UIView {
    
    func update(_ message: String) {
        messageLabel.text = message
    }
    
    override init(frame: CGRect) {
        messageLabel = UILabel()
        super.init(frame: frame)

        messageLabel.textAlignment = .center
        addSubview(messageLabel)

        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0)
        let leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5.0)
        let trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5.0)
        let bottomConstraint = messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0)
        let centerXConstraint = messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centerYConstraint = messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        self.addConstraints([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint, centerXConstraint, centerYConstraint])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let messageLabel: UILabel
}
