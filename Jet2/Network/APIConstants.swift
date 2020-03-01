//
//  APIConstants.swift
//  Jet2
//
//  Created by Nikhil1 Yawalkar on 29/02/20.
//  Copyright © 2020 niks. All rights reserved.
//

import Foundation

struct APIConstants{
    
    private static let baseUrl = "https://dummy.restapiexample.com"
    
    private static let emplyeeList = "/api/v1/employees"
    
    struct DEV {
        static let employeeListUrl = baseUrl + emplyeeList
    }
}
