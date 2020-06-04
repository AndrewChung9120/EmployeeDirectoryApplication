//
//  EmployeeListInteractorTests.swift
//  EmployeeDirectoryApplicationTests
//
//  Created by Zebing Zong on 5/11/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import XCTest
@testable import EmployeeDirectoryApplication

class EmployeeListInteractorTests: XCTestCase {
    
    private var employeesInfoService: EmployeesInfoServicingMock!
    private var employeeListPresenter: EmployeeListPresentableMock!
    
    private var employeeListInteractor: EmployeeListInteractor!
    
    override func setUp() {
        super.setUp()
        
        employeesInfoService = EmployeesInfoServicingMock()
        employeeListPresenter = EmployeeListPresentableMock()
        
        employeeListInteractor = EmployeeListInteractor(employeesInfoService: employeesInfoService,
                                                        employeeListPresenter: employeeListPresenter)
    }
    
    func testActivateWithNormalResponse() {
        employeesInfoService.response = EmployeesResponse(employees: mockEmployees())
        employeeListPresenter.setDataHandler = { (employees: [Employee]) in
            XCTAssert(employees.count == 2)
            XCTAssert(employees[0].full_name == "employee1")
            XCTAssert(employees[1].full_name == "employee2")
        }

        employeeListInteractor.activate()
                
        XCTAssert(employeesInfoService.getEmployeesInfoCallCount == 1)
        XCTAssert(employeeListPresenter.setDataCallCount == 1)
        XCTAssert(employeeListPresenter.showFullScreenViewCallCount == 0)
    }
    
    func testActivateWithEmptyResponse() {
        employeesInfoService.response = EmployeesResponse(employees: [])
        employeeListPresenter.showFullScreenViewHandler = { (message: String) in
            XCTAssert(message == "Empty Employees Info")
        }

        employeeListInteractor.activate()
                
        XCTAssert(employeesInfoService.getEmployeesInfoCallCount == 1)
        XCTAssert(employeeListPresenter.showFullScreenViewCallCount == 1)
        XCTAssert(employeeListPresenter.setDataCallCount == 0)
    }
    
    func testActivateWithError() {
        employeesInfoService.error = GetEmployeesInfoError.timeout
        employeeListPresenter.showFullScreenViewHandler = { (message: String) in
            XCTAssert(message == "timeout")
        }

        employeeListInteractor.activate()
                
        XCTAssert(employeesInfoService.getEmployeesInfoCallCount == 1)
        XCTAssert(employeeListPresenter.showFullScreenViewCallCount == 1)
        XCTAssert(employeeListPresenter.setDataCallCount == 0)
    }
    
    private func mockEmployees() -> [Employee] {
        let employee1 = Employee(uuid: "uuid",
                                 full_name: "employee1",
                                 phone_number: "phone_number",
                                 email_address: "email_address",
                                 biography: "biography",
                                 photo_url_small: "photo_url_small",
                                 photo_url_large: "photo_url_large",
                                 team: "team",
                                 employee_type: .FULL_TIME)
        let employee2 = Employee(uuid: "uuid",
                                 full_name: "employee2",
                                 phone_number: "phone_number",
                                 email_address: "email_address",
                                 biography: "biography",
                                 photo_url_small: "photo_url_small",
                                 photo_url_large: "photo_url_large",
                                 team: "team",
                                 employee_type: .FULL_TIME)
        return [employee1, employee2]
    }
}


