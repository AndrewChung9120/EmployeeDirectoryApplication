//
//  EmployeesInfoProvider.swift
//  EmployeeDirectoryApplication
//
//  Created by Andrew on 6/5/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

protocol EmployeesInfoProviding {
    func getEmployeesInfo(completion: @escaping (EmployeesResponse?, Error?) -> Void)
}

class EmployeesInfoProvider: EmployeesInfoProviding {
    
    func getEmployeesInfo(completion: @escaping (EmployeesResponse?, Error?) -> Void) {
        
        let (data, error) = persistentStore.getData(key: EmployeesResponse.storeKey)
//        print(error)
        if let data = data {
            do {
                let response = try JSONDecoder().decode(EmployeesResponse.self, from: data)
                completion(response, nil)
                print("Get data from persistentStore")
                return
            } catch let error {
                completion(nil, error)
            }
        }
        
        let completionWrapper: (Data?, Error?) -> Void = { data, error in
            guard let data = data else {
                return
            }
            
            let error = self.persistentStore.write(key: EmployeesResponse.storeKey, data: data)
//            print(error)
            print("Write data to persistentStore")
            do {
                let response = try JSONDecoder().decode(EmployeesResponse.self, from: data)
                completion(response, nil)
                print("Get data from service")
            } catch let error {
                completion(nil, error)
            }
        }
        
        employeesInfoService.getEmployeesInfo(completion: completionWrapper)
    }
    
    init(persistentStore: PersistentStoring,
         employeesInfoService: EmployeesInfoServicing) {
        self.persistentStore = persistentStore
        self.employeesInfoService = employeesInfoService
    }
    
    private let persistentStore: PersistentStoring
    private let employeesInfoService: EmployeesInfoServicing
}
