//
//  NetworkManager.swift
//  Jet2
//
//  Created by Nikhil1 Yawalkar on 29/02/20.
//  Copyright © 2020 niks. All rights reserved.
//

import Foundation
import Alamofire

enum Result <T, E>{
    case success(T)
    case error(E)
}

class NetworkManager : NSObject {
    
    private override init() {
        super.init()
    }
    
    // Create a shared Instance
    static let _shared = NetworkManager()
    
    // Shared Function
    class func shared() -> NetworkManager{
        return _shared
    }
    
    func isReachable() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func fetchEmployeeData(completion: @escaping (Result<[Employee]?, Error?>) -> Void){
        if let employeeListUrl = URL(string: APIConstants.DEV.employeeListUrl) {
            let task = URLSession.shared.dataTask(with: employeeListUrl) { (data, response, error) in
                guard let data = data, error == nil else {
                    completion(.error(error))
                    return
                }
                let employeeList = EmployeeListParser().parseData(data: data)
                completion(.success(employeeList))
            }
            task.resume()
        }
        
    }
}

