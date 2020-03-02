//
//  AppConstants.swift
//  Jet2
//
//  Created by Nikhil1 Yawalkar on 29/02/20.
//  Copyright © 2020 niks. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants {
    static let appTitle = "Jet2"
    static let employeeListVCIdentifier = "EmployeeListVC"
    static let employeeDetailVCIdentifier = "EmployeeDetailVC"
    static let employeeCellIdentifier = "EmployeeListCell"
    
    //DetailView Constants
    static let idText = "ID : "
    static let salaryText = "Salary : "
    static let ageText = "Age : "
    static let emptyText = "######"
    
    static let profilePlaceholder = UIImage(named: "profile_icon")
    
    static let alert = "Alert"
    static let okAction = "Ok"
    static let cancelAction = "Cancel"
    
    static let networkError = "Unable to reach server. Please check your network connection"
    
    static let sortTitle = "Sort"
    static let nameSortAsc = "Name  : A -> Z"
    static let nameSortDsc = "Name  : Z -> A"
    static let ageSortAsc = "Age  : 1 -> 99"
    static let ageSortDsc = "Age  : 99 -> A"
    
    static let actionsheetCheckProperty = "checked"
}
