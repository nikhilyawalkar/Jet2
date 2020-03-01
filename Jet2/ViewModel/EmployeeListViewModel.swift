//
//  EmployeeListViewModel.swift
//  Jet2
//
//  Created by Nikhil1 Yawalkar on 01/03/20.
//  Copyright © 2020 niks. All rights reserved.
//

import Foundation
import UIKit

class EmployeeListViewModel{
    
    var employees : [Employee] = []
    
    let networkManager = NetworkManager()
    
    func fetchEmployeeData(dataChanged : @escaping ()->Void){
        networkManager.fetchEmployeeData { (result) in
            switch result{
            case .success(let data):
                self.employees = data ?? []
                dataChanged()
            case.error(let error):
                print(error!)
            }
            
        }
    }
    
    func getItemCount()->Int{
        return employees.count
    }
    
    func configureCell(cell : EmployeeListCell, atIndex index : Int){
        let cellModel = EmployeeCellViewModel(model : employees[index])
        cell.nameLabel.text = cellModel.name
        cell.profileImageView.image = cellModel.profileImage
    }
    
    func getDetailViewModel(forIndex index : Int) -> EmployeeDetailViewModel {
        return EmployeeDetailViewModel(model: employees[index])
    }
}

class EmployeeCellViewModel{
    let model : Employee
    
    init(model employee : Employee) {
        self.model = employee
    }
    
    var name : String?{
        return model.name
    }
    
    var profileUrl : String?{
        return model.profileUrl
    }
    
    var profileImage : UIImage{
        return UIImage(named: "profile_icon")!
    }
    
}
