//
//  HomeVC.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 08/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var homeView: HomeView!
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.setup()
        setupNavController()
    }
    
    //MARK:- Public Methods
    class func create() -> HomeVC {
        let homeVC: HomeVC = UIViewController.create(storyboardName: Storyboards.home, identifier: ViewControllers.homeVC)
        return homeVC
    }

    //MARK:- IBActions
    @IBAction func homeNurseBtnPressed(_ sender: UIButton) {
        print("Home Nurse")
    }
    
    @IBAction func veterinaryBtnPressed(_ sender: UIButton) {
        print("Veterinary")
    }
    
    @IBAction func mriBtnPressed(_ sender: UIButton) {
        print("MRI")
    }
    
    @IBAction func humanMedicineBtnPressed(_ sender: UIButton) {
        print("Human Medicine")
    }
}

//MARK:- Private Methods
extension HomeVC {
    private func setupNavController() {
        self.navigationItem.title = "Choose Services"
        self.navigationController?.navigationBar.clipsToBounds = true
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "PTSans-Bold", size: 20) as Any
        ]
    }
}
