//
//  SignupVC.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 27/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var signupView: SignupView!
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        signupView.setup()
        setupNavigation()
    }
}

//MARK:- Private Methods
extension SignupVC {
    private func setupNavigation() {
        self.setupNavController(title: L10n.signupNav)
        self.setupNavigationItems(backAction: .popUpCurrent)
    }
}
