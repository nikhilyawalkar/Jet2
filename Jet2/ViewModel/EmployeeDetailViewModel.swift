//
//  EmployeeDetailViewModel.swift
//  Jet2
//
//  Created by Nikhil1 Yawalkar on 01/03/20.
//  Copyright © 2020 niks. All rights reserved.
//

import Foundation
import UIKit

class EmployeeDetailViewModel{
    let model : EmployeeItem
    
    init(model : EmployeeItem) {
        self.model = model
    }
    
    var id : String{
        if let modelId = model.id {
            return AppConstants.idText + modelId
        } else {
            return AppConstants.idText + AppConstants.emptyText
        }
    }
    
    var name : String{
        if let modelName = model.name {
            return modelName
        } else {
            return AppConstants.emptyText
        }
    }
    
    var profileUrl : String?{
        return model.profileUrl
    }
    
    var salary : String{
        if let salary = model.salary {
            return AppConstants.salaryText + salary
        } else {
            return AppConstants.salaryText + AppConstants.emptyText
        }
    }
    
    var age : String{
        if let age = model.age {
            return AppConstants.ageText + age
        } else {
            return AppConstants.ageText + AppConstants.emptyText
        }
    }
}
