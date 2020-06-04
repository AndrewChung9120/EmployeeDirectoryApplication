//
//  ViewController.swift
//  EmployeeDirectoryApplication
//
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import Kingfisher

class EmployeeListViewController: UITableViewController, EmployeeListPresentable {
    
    init() {
        super.init(style: .grouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - EmployeeListPresentable
    
    func setData(_ employees: [Employee]) {
        self.employees = employees
        
        DispatchQueue.main.async {
             self.activityIndicator.stopAnimating()
             self.tableView.reloadData()
         }
    }
    
    func showFullScreenView(_ message: String) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.fullScreenView.isHidden = false
            self.fullScreenView.update(message)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeListCell.identifier, for: indexPath)
        
        guard indexPath.row < employees.count else {
            return cell
        }
        
        let employee = employees[indexPath.row]
        cell.textLabel?.text = employee.full_name
        cell.detailTextLabel?.text = employee.team
        cell.selectionStyle = .none
        
        cell.imageView?.contentMode = .scaleAspectFit
        let url = URL(string: employee.photo_url_small ?? "")
        let image = UIImage(named: "default_profile_icon")
        cell.imageView?.kf.indicatorType = .activity
        cell.imageView?.kf.setImage(with: url, placeholder: image)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    // MARK: - Private
    
    private func setupUI() {
        tableView.alwaysBounceVertical = true
        tableView.showsVerticalScrollIndicator = true
        tableView.register(EmployeeListCell.self, forCellReuseIdentifier: EmployeeListCell.identifier)
        
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        fullScreenView.isHidden = true
        view.addSubview(fullScreenView)
    }
    
    private func setupConstraints() {
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        activityIndicator.center = tableView.center
        
        fullScreenView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        fullScreenView.isHidden = true
    }
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .gray
        return view
    }()
    
    private let fullScreenView: FullScreenView = {
        return FullScreenView(frame:.zero)
    }()
    
    private var employees = [Employee]()
}
