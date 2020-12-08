//
//  ServiceSearchVC.swift
//  IDEHospital
//
//  Created by Ziad on 12/8/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class ServiceSearchVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var mainView: ServiceSearchView!
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
    }
    
    // MARK:- Public Methods
    class func create() -> ServiceSearchVC {
        let serviceSearchVC: ServiceSearchVC = UIViewController.create(storyboardName: Storyboards.serviceSearch, identifier: ViewControllers.serviceSearchVC)
        return serviceSearchVC
    }
}

extension ServiceSearchVC {
    // MARK:- Private Methods
    private func setupNavigationItems() {
        navigationController?.navigationBar.barTintColor = UIColor(white: 204.0 / 255.0, alpha: 1.0)
        navigationItem.title = "Service Search"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let backItem = UIBarButtonItem(image: UIImage(named: "back2"), style: .done, target: self, action: #selector(popUp))
        backItem.tintColor = UIColor(red: 132.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
        let leftPadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftPadding.width = 18
        navigationItem.leftBarButtonItems = [leftPadding, backItem]
        let settingsItem = UIBarButtonItem(image: UIImage(named: "settings"), style: .done, target: self, action: #selector(showSettings))
        settingsItem.tintColor = UIColor(red: 132.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
        let rightPadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightPadding.width = 18
        navigationItem.rightBarButtonItems = [rightPadding, settingsItem]
    }
    
    // MARK:- Objc Methods
    @objc private func popUp() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func showSettings() {
        print("Show Settings")
    }
}
