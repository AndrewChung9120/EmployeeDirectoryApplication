//
//  EmployeeListInteractor.swift
//  EmployeeDirectoryApplication
//
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

protocol EmployeeListPresentable {
    func setData(_ employees: [Employee])
    func showFullScreenView(_ message: String)
}

class EmployeeListInteractor {
    
    init(employeesInfoService: EmployeesInfoServicing,
         employeeListPresenter: EmployeeListPresentable) {
        self.employeesInfoService = employeesInfoService
        self.employeeListPresenter = employeeListPresenter
    }
    
    func activate() {
        employeesInfoService.getEmployeesInfo { (response: EmployeesResponse?, error: Error?) in
            if let error = error {
                self.employeeListPresenter.showFullScreenView(error.localizedDescription)
                return
            }
            
            guard let employees = response?.employees, employees.count > 0 else {
                self.employeeListPresenter.showFullScreenView("Empty Employees Info")
                return
            }

            let sortedData = employees.sorted(by: {
                lhs, rhs in
                return lhs.full_name < rhs.full_name
            })
            self.employeeListPresenter.setData(sortedData)
        }
    }
    
    // MARK: - Private
    
    private let employeesInfoService: EmployeesInfoServicing
    private let employeeListPresenter: EmployeeListPresentable
}
