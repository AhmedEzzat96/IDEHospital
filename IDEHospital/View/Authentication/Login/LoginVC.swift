//
//  LoginVC.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 27/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet var loginView: LoginView!
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.setup()
        setupNavigation()
    }
}

//MARK:- Private Methods
extension LoginVC {
    private func setupNavigation() {
        self.setupNavController(title: L10n.loginNav)
        self.setupNavigationItems(backAction: .popUpCurrent)
    }
}
