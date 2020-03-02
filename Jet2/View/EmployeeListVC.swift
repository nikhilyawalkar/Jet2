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
        setupNavigationBar()
        Loader.shared.showLoading(on: self)
        viewModel.fetchEmployeeData()
        
        viewModel.dataChanged = { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                Loader.shared.stopLoading()
            }
        }
        
        viewModel.needAlert = { message in
            DispatchQueue.main.async {
                Loader.shared.stopLoading()
                Utility.showAlert(with: message, on: self)
            }
        }
    }
    
    
    func setupNavigationBar(){
        self.title = AppConstants.appTitle
        if !tableView.isEditing{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonClicked))
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonClicked))
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    @objc func editButtonClicked(){
        tableView.setEditing(true, animated: true)
        setupNavigationBar()
    }
    
    @objc func doneButtonClicked(){
        tableView.setEditing(false, animated: true)
        setupNavigationBar()
    }
    
    @IBAction func sortButtonAction(_ sender: Any) {
        openSortingOption()
    }
    
    func openSortingOption(){
        let alertController = UIAlertController(title: AppConstants.sortTitle, message: nil, preferredStyle: .actionSheet)
        let sortNameAscAction = UIAlertAction(title: AppConstants.nameSortAsc, style: .default, handler: { (action) in
            self.viewModel.sortingOption = .nameAsc
        })
        if viewModel.sortingOption == .nameAsc {
            sortNameAscAction.setValue(true, forKey: AppConstants.actionsheetCheckProperty)
        }
        
        let sortNameDscAction = UIAlertAction(title: AppConstants.nameSortDsc , style: .default, handler: { (action) in
            self.viewModel.sortingOption = .nameDsc
        })
        if viewModel.sortingOption == .nameDsc {
            sortNameDscAction.setValue(true, forKey: AppConstants.actionsheetCheckProperty)
        }
        
        let sortAgeAscAction = UIAlertAction(title: AppConstants.ageSortAsc, style: .default, handler: { (action) in
            self.viewModel.sortingOption = .ageAsc
        })
        if viewModel.sortingOption == .ageAsc {
            sortAgeAscAction.setValue(true, forKey: AppConstants.actionsheetCheckProperty)
        }
        
        let sortAgeDscAction = UIAlertAction(title: AppConstants.ageSortDsc, style: .default, handler: { (action) in
            self.viewModel.sortingOption = .ageDsc
        })
        if viewModel.sortingOption == .ageDsc {
            sortAgeDscAction.setValue(true, forKey: AppConstants.actionsheetCheckProperty)
        }
       
        let cancelAction = UIAlertAction(title: AppConstants.cancelAction, style: .cancel, handler: { (action) in
            
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            viewModel.performDeleteAction(atIndex: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
