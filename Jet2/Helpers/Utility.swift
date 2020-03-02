//
//  Utility.swift
//  Jet2
//
//  Created by Nikhil1 Yawalkar on 29/02/20.
//  Copyright © 2020 niks. All rights reserved.
//

import Foundation
import UIKit

class Utility : NSObject {
    static func showAlert(with message : String , on viewController : UIViewController){
        let alert = UIAlertController(title: AppConstants.alert, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AppConstants.okAction, style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
