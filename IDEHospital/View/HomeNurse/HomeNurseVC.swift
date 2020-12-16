//
//  HomeNurseVC.swift
//  IDEHospital
//
//  Created by Ziad on 12/16/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class HomeNurseVC: UIViewController {

    @IBOutlet weak var mainView: HomeNurseView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setup()
        // Do any additional setup after loading the view.
    }

    //MARK:- Public Methods
    class func create() -> HomeNurseVC {
        let homeNurseVC: HomeNurseVC = UIViewController.create(storyboardName: Storyboards.homeNurse, identifier: ViewControllers.homeNurseVC)
        return homeNurseVC
    }
}
