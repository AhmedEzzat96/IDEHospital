//
//  ResetPasswordVC.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 26/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet var resetPasswordView: ResetPasswordView!
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordView.setup()
        setupNavigation()
    }
    
}

//MARK:- Private Methods
extension ResetPasswordVC {
    private func setupNavigation() {
        self.setupNavController(title: L10n.resetPassword)
        self.setupNavigationItems(backAction: .popUpCurrent)
    }
}
