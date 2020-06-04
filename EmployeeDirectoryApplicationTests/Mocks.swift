//
//  Mocks.swift
//  EmployeeDirectoryApplicationTests
//
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation
@testable import EmployeeDirectoryApplication

final class EmployeesInfoServicingMock: EmployeesInfoServicing {
    
    var response: EmployeesResponse?
    var error: Error?
    
    func getEmployeesInfo(completion: @escaping (EmployeesResponse?, Error?) -> Void) {
        getEmployeesInfoCallCount += 1
        completion(response, error)
    }
    
    private(set) var getEmployeesInfoCallCount: Int = 0
    
}

final class EmployeeListPresentableMock: EmployeeListPresentable {
    
    var setDataHandler: (([Employee]) -> ())?
    var showFullScreenViewHandler: ((String) -> ())?
    
    func setData(_ employees: [Employee]) {
        setDataCallCount += 1
        
        if let handler = setDataHandler {
            handler(employees)
        }
    }
    
    func showFullScreenView(_ message: String) {
        showFullScreenViewCallCount += 1
        
        if let handler = showFullScreenViewHandler {
            handler(message)
        }
    }
    
    private(set) var setDataCallCount: Int = 0
    private(set) var showFullScreenViewCallCount: Int = 0
}
