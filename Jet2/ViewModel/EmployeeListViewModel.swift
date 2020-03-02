//
//  EmployeeListViewModel.swift
//  Jet2
//
//  Created by Nikhil1 Yawalkar on 01/03/20.
//  Copyright © 2020 niks. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

enum SortingOption {
    case nameAsc
    case nameDsc
    case ageAsc
    case ageDsc
}

class EmployeeListViewModel{
    
    var employees : [EmployeeItem] = []
    
    var sortingOption : SortingOption = .nameAsc{
        didSet{
            sortData()
        }
    }
    
    var dataChanged : (()->Void)?
    var needAlert : ((_ message : String) -> Void)?
    
    func fetchEmployeeData(){
        if NetworkManager._shared.isReachable() {
            NetworkManager._shared.fetchEmployeeData { (result) in
                switch result{
                case .success(let data):
                    let employeeResponse = data ?? []
                    CoreDataManager._shared.saveEmployeeDataToDatabase(dataForSaving: employeeResponse)
                    self.employees = CoreDataManager._shared.getEmployeeDataFromDB()
                    self.sortData()
                case.error(let error):
                    print(error!)
                }
                
            }
        } else {
            self.needAlert?(AppConstants.networkError)
            self.employees = CoreDataManager._shared.getEmployeeDataFromDB()
            self.sortData()
        }
    }
    
    func sortData(){
        switch self.sortingOption {
        case .nameAsc:
            self.employees.sort(by: {$0.name ?? "" < $1.name ?? ""})
            
        case .nameDsc:
            self.employees.sort(by: {$0.name ?? "" > $1.name ?? ""})
            
        case .ageAsc:
            self.employees.sort(by: {
                guard let first: Int = Int($0.age ?? "-1") else { return false }
                guard let second: Int = Int($1.age ?? "-1") else { return false }
                
                return first < second
            })
            
        case .ageDsc:
            self.employees.sort(by: {
                guard let first: Int = Int($0.age ?? "-1") else { return false }
                guard let second: Int = Int($1.age ?? "-1") else { return false }
                
                return first > second
            })
        }
        dataChanged?()
    }
    
    func getItemCount()->Int{
        return employees.count
    }
    
    func configureCell(cell : EmployeeListCell, atIndex index : Int){
        let cellModel = EmployeeCellViewModel(model : employees[index])
        cell.nameLabel.text = cellModel.name
        if let url = URL(string: cellModel.profileUrl ?? ""){
            cell.profileImageView.af.setImage(withURL: url, cacheKey: cellModel.profileUrl, placeholderImage: AppConstants.profilePlaceholder)
        } else {
            cell.profileImageView.image = AppConstants.profilePlaceholder
        }
    }
    
    func getDetailViewModel(forIndex index : Int) -> EmployeeDetailViewModel {
        return EmployeeDetailViewModel(model: employees[index])
    }
    
    func performDeleteAction(atIndex indexPath: IndexPath){
        self.employees.remove(at: indexPath.row)
    }
}

class EmployeeCellViewModel{
    let model : EmployeeItem
    
    init(model employee : EmployeeItem) {
        self.model = employee
    }
    
    var name : String?{
        return model.name
    }
    
    var profileUrl : String?{
        return model.profileUrl
    }
}
