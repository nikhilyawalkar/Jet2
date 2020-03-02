//
//  LoadingView.swift
//  Jet2
//
//  Created by Nikhil1 Yawalkar on 02/03/20.
//  Copyright © 2020 niks. All rights reserved.
//

import UIKit

class Loader {
    static var shared = Loader()
    
    let backgroundView = UIView()
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    private func setupView(){
        backgroundView.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        backgroundView.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
        backgroundView.layer.cornerRadius = 5
        backgroundView.layer.masksToBounds = true
    }
    func showLoading(on viewController :UIViewController){
        setupView()
        backgroundView.center = viewController.view.center
        activityIndicator.center = viewController.view.center
        activityIndicator.startAnimating()
        viewController.view.addSubview(backgroundView)
        viewController.view.addSubview(activityIndicator)
    }
    
    func stopLoading(){
        activityIndicator.stopAnimating()
        backgroundView.removeFromSuperview()
        activityIndicator.removeFromSuperview()
    }
    
}
