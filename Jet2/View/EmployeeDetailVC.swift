//
//  EmployeeDetailVC.swift
//  Jet2
//
//  Created by Nikhil1 Yawalkar on 29/02/20.
//  Copyright © 2020 niks. All rights reserved.
//

import UIKit

class EmployeeDetailVC: UIViewController {

    var viewModel : EmployeeDetailViewModel?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        profileImageView.image = viewModel?.profileImage
        nameLabel.text = viewModel?.name
        salaryLabel.text = viewModel?.salary
        ageLabel.text = viewModel?.age
        idLabel.text = viewModel?.id
    }
}
