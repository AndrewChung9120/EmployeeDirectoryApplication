//
//  EmployeesInfoService.swift
//  EmployeeDirectoryApplication
//
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

enum GetEmployeesInfoError: LocalizedError {
    case timeout
    case invalidInput
    
    var errorDescription: String? {
        switch self {
            case .timeout:
                return "timeout"
            case .invalidInput:
                return "invalidInput"
        }
    }
}

protocol EmployeesInfoServicing {
    func getEmployeesInfo(completion: @escaping (Data?, Error?) -> Void)
}

class EmployeesInfoService: EmployeesInfoServicing {
    
    private let urlComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "s3.amazonaws.com"
        urlComponents.path = "/sq-mobile-interview/employees.json"
        // urlComponents.path = "/sq-mobile-interview/employees_malformed.json"
        // urlComponents.path = "/sq-mobile-interview/employees_empty.json"
        return urlComponents
    }()
    
    func getEmployeesInfo(completion: @escaping (Data?, Error?) -> Void) {
        
        guard let url = self.urlComponents.url else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession(configuration: .ephemeral).dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
        task.resume()
    }
}
