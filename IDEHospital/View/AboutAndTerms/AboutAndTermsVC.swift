//
//  AboutVC.swift
//  IDEHospital
//
//  Created by Ziad on 12/28/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

protocol AboutAndTermsVCProtocol: class {
    func showLoader()
    func hideLoader()
    func showAlert(title: String, message: String)
    func displayText(_ text: String)
}

enum InfoType {
    case aboutUs
    case termsAndConditions
}

class AboutAndTermsVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var mainView: AboutAndTermsView!
    
    // MARK:- Properties
    var viewModel: AboutAndTermsViewModelProtocol!
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setup()
        setupNavigationController()
        viewModel.getAboutOrTerms()
    }

    //MARK:- Public Methods
    class func create(status: InfoType) -> AboutAndTermsVC {
        let aboutAndTermsVC: AboutAndTermsVC = UIViewController.create(storyboardName: Storyboards.aboutAndTerms, identifier: ViewControllers.aboutAndTerms)
        aboutAndTermsVC.viewModel = AboutAndTermsViewModel(view: aboutAndTermsVC, status: status)
        return aboutAndTermsVC
    }
}

// MARK:- Private Methods
extension AboutAndTermsVC {
    private func setupNavigationController() {
        setupNavController(title: viewModel.getTitle())
        setupNavigationItems(backAction: .dismissCurrent, isSettingEnabled: false)
    }
}

// MARK:- AboutAndTermsVC Protocol
extension AboutAndTermsVC: AboutAndTermsVCProtocol {
    func showLoader() {
        view.showActivityIndicator()
    }
    
    func hideLoader() {
        view.hideActivityIndicator()
    }
    
    func showAlert(title: String, message: String) {
        showSimpleAlert(title: title, message: message)
    }
    
    func displayText(_ text: String) {
        mainView.aboutOrTermsLabel.text = text
    }
}
