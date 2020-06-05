//
//  EmployeeDetailsViewController.swift
//  EmployeeDirectoryApplication
//
//  Created by Andrew on 6/5/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import Kingfisher

protocol EmployeeDetailsPresentable {
    func set(fullName: String, phoneNumber: String, emailAddress: String, biography: String, photoURL: String, team: String)
}

class EmployeeDetailsViewController: UIViewController, EmployeeDetailsPresentable {
    
    func set(fullName: String, phoneNumber: String, emailAddress: String, biography: String, photoURL: String, team: String) {
        fullNameLabel.text = fullName
        phoneNumberButton.setTitle(phoneNumber, for: .normal)
        emailAddressLabel.text = emailAddress
        biographyLabel.text = biography
        teamLabel.text = team
        
        let url = URL(string: photoURL)
        let image = UIImage(named: "default_profile_icon")
        photoView.kf.indicatorType = .activity
        photoView.kf.setImage(with: url, placeholder: image)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstrains()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(fullNameLabel)
        
        phoneNumberButton.addTarget(self, action: #selector(pressedPhoneNumber), for: .touchUpInside)
        view.addSubview(phoneNumberButton)
        view.addSubview(emailAddressLabel)
        view.addSubview(biographyLabel)
        view.addSubview(teamLabel)
        view.addSubview(photoView)
    }
    
    private func setupConstrains() {
        let topAncher = view.safeAreaLayoutGuide.topAnchor
        
        let fullNameTopConstraint = fullNameLabel.topAnchor.constraint(equalTo: topAncher, constant: 10.0)
        let fullNameLeadingConstraint = fullNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let fullNameTrailingConstraint = fullNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        view.addConstraints([fullNameTopConstraint, fullNameLeadingConstraint, fullNameTrailingConstraint])
        
        let phoneNumberTopConstraint = phoneNumberButton.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 10.0)
        let phoneNumberLeadingConstraint = phoneNumberButton.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let phoneNumberTrailingConstraint = phoneNumberButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        view.addConstraints([phoneNumberTopConstraint, phoneNumberLeadingConstraint, phoneNumberTrailingConstraint])
        
        let emailAddressTopConstraint = emailAddressLabel.topAnchor.constraint(equalTo: phoneNumberButton.bottomAnchor, constant: 10.0)
        let emailAddressLeadingConstraint = emailAddressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let emailAddressTrailingConstraint = emailAddressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        view.addConstraints([emailAddressTopConstraint, emailAddressLeadingConstraint, emailAddressTrailingConstraint])
        
        let photoViewTopConstraint = photoView.topAnchor.constraint(equalTo: emailAddressLabel.bottomAnchor, constant: 10.0)
        let phoneViewLeadingConstraint = photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let phoneViewTailingConstraint = photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let phoneViewBottomConstraint = photoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0)
        view.addConstraints([photoViewTopConstraint, phoneViewLeadingConstraint, phoneViewTailingConstraint, phoneViewBottomConstraint])
    }
    
    @objc private func pressedPhoneNumber(sender: UIButton) {
        if let phoneNumber = sender.titleLabel?.text, let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneNumberButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var emailAddressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var teamLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}

// full_name, phone_number, email_address, biography, photo_url_large, team

