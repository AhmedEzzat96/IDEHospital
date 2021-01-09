//
//  EditProfileVC.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 09/01/2021.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet weak var editProfileView: EditProfileView!
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavController(title: "EDIT PROFILE")
        editProfileView.setup()
    }
    
}
