//
//  Employee.swift
//  Jet2
//
//  Created by Nikhil1 Yawalkar on 29/02/20.
//  Copyright © 2020 niks. All rights reserved.
//

import Foundation

struct EmployeeListParser{
    let success = "success"
    
    func parseData(data:Data) -> [Employee] {
        let decoder = JSONDecoder()
        do {
            let baseResult = try decoder.decode(EmployeeBaseParser.self, from: data)
            if let employeeData = baseResult.data ,baseResult.status == success{
                return employeeData
            } else {
                return[]
            }
        } catch {
            return []
        }
    }
}

struct EmployeeBaseParser : Decodable {
    let status : String?
    let data : [Employee]?
    
    enum CodingKeys : String,CodingKey{
        case status
        case data
    }
    
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        status = try container.decodeIfPresent(String.self, forKey: .status)
        data = try container.decodeIfPresent([Employee].self, forKey: .data)
    }
}

struct Employee : Decodable {
    let id : String?
    let name : String?
    let age : String?
    let salary : String?
    let profileUrl : String?
    
    enum CodingKeys : String, CodingKey {
        case id
        case name = "employee_name"
        case age = "employee_age"
        case salary = "employee_salary"
        case profileUrl = "profile_image"
    }
    
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        age = try container.decodeIfPresent(String.self, forKey: .age)
        salary = try container.decodeIfPresent(String.self, forKey: .salary)
        profileUrl = try container.decodeIfPresent(String.self, forKey: .profileUrl)
    }
}

