//
//  Employee.swift
//  EmployeeDirectoryApplication
//
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

struct EmployeesResponse: Codable {
    let employees: [Employee]
    
    static let storeKey = "persistentStore.EmployeesResponse"
}
