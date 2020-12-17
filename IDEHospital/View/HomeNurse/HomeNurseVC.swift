//
//  HomeNurseVC.swift
//  IDEHospital
//
//  Created by Ziad on 12/16/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

protocol HomeNurseVCProtocol: class {
    func addPlaceholder()
}

class HomeNurseVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var mainView: HomeNurseView!
    
    // MARK:- Properties
    var viewModel: HomeNurseViewModelProtocol!
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setup()
        mainView.detailsTextView.delegate = self
        // Do any additional setup after loading the view.
    }

    //MARK:- Public Methods
    class func create() -> HomeNurseVC {
        let homeNurseVC: HomeNurseVC = UIViewController.create(storyboardName: Storyboards.homeNurse, identifier: ViewControllers.homeNurseVC)
        homeNurseVC.viewModel = HomeNurseViewModel(view: homeNurseVC)
        return homeNurseVC
    }
    @IBAction func sendRequestButtonPressed(_ sender: UIButton) {
    }
}

// MARK:- TextView Delegate
extension HomeNurseVC: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        DispatchQueue.main.async {
            textView.text = ""
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        viewModel.textViewShouldEndEditing(text: textView.text)
        return true
    }
}

// MARK:- HomeNurseVC Protocol
extension HomeNurseVC: HomeNurseVCProtocol {
    func addPlaceholder() {
        mainView.detailsTextView.text = "Enter Details"
    }
}
