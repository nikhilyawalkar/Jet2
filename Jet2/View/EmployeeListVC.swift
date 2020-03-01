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
        viewModel.fetchEmployeeData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func sortButtonAction(_ sender: Any) {
        
    }
}

extension EmployeeListVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getItemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.employeeCellIdentifier, for: indexPath) as! EmployeeListCell
        viewModel.configureCell(cell: cell, atIndex: indexPath.row)
        cell.profileImageView.backgroundColor = .red
        return cell
    } 
}

extension EmployeeListVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: AppConstants.employeeDetailVCIdentifier) as! EmployeeDetailVC
        self.present(detailVC, animated: true, completion: nil)
    }
}
