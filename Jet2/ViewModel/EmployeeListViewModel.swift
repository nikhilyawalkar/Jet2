//
//  EmployeeListViewModel.swift
//  Jet2
//
//  Created by Nikhil1 Yawalkar on 01/03/20.
//  Copyright © 2020 niks. All rights reserved.
//

import Foundation

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
    
}
