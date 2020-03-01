//
//  EmployeeListVC.swift
//  Jet2
//
//  Created by Nikhil1 Yawalkar on 29/02/20.
//  Copyright © 2020 niks. All rights reserved.
//

import UIKit

class EmployeeListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = EmployeeListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = AppConstants.appTitle
        viewModel.fetchEmployeeData()
        viewModel.dataChanged = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func sortButtonAction(_ sender: Any) {
        openSortingOption()
    }
    
    func openSortingOption(){
        let alertController = UIAlertController(title: "Sort", message: nil, preferredStyle: .actionSheet)
        let sortNameAscAction = UIAlertAction(title: "Name  : A -> Z", style: .default, handler: { (action) in
            self.viewModel.sortingOption = .nameAsc
        })
        if viewModel.sortingOption == .nameAsc {
            sortNameAscAction.setValue(true, forKey: "checked")
        }
        
        let sortNameDscAction = UIAlertAction(title: "Name  : Z -> A", style: .default, handler: { (action) in
            self.viewModel.sortingOption = .nameDsc
        })
        if viewModel.sortingOption == .nameDsc {
            sortNameDscAction.setValue(true, forKey: "checked")
        }
        
        let sortAgeAscAction = UIAlertAction(title: "Age  : 1 -> 99", style: .default, handler: { (action) in
            self.viewModel.sortingOption = .ageAsc
        })
        if viewModel.sortingOption == .ageAsc {
            sortAgeAscAction.setValue(true, forKey: "checked")
        }
        
        let sortAgeDscAction = UIAlertAction(title: "Age  : 99 -> A", style: .default, handler: { (action) in
            self.viewModel.sortingOption = .ageDsc
        })
        if viewModel.sortingOption == .ageDsc {
            sortAgeDscAction.setValue(true, forKey: "checked")
        }
       
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        })
        
        alertController.addAction(sortNameAscAction)
        alertController.addAction(sortNameDscAction)
        alertController.addAction(sortAgeAscAction)
        alertController.addAction(sortAgeDscAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
}

extension EmployeeListVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getItemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.employeeCellIdentifier, for: indexPath) as! EmployeeListCell
        viewModel.configureCell(cell: cell, atIndex: indexPath.row)
        return cell
    } 
}

extension EmployeeListVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: AppConstants.employeeDetailVCIdentifier) as! EmployeeDetailVC
        detailVC.viewModel = viewModel.getDetailViewModel(forIndex: indexPath.row)
        self.present(detailVC, animated: true, completion: nil)
    }
}
