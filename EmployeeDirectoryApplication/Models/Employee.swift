//
//  Employee.swift
//  EmployeeDirectoryApplication
//
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

enum EmployeeType: String, Codable {
    case FULL_TIME
    case PART_TIME
    case CONTRACTOR
}

struct Employee: Codable {
    let uuid: String
    let full_name: String
    let phone_number: String?
    let email_address: String
    let biography: String?
    let photo_url_small: String?
    let photo_url_large: String?
    let team: String
    let employee_type: EmployeeType
}

// full_name, phone_number, email_address, biography, photo_url_large, team
