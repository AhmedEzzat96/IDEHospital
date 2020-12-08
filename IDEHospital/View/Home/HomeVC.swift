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
        navigationController?.title = "Choose Services"
        navigationController?.navigationBar.backgroundColor = .darkGray
    }
}
