//
//  YesOrNoPopUpVC.swift
//  IDEHospital
//
//  Created by Ziad on 1/5/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit

protocol YesOrNoPopUpVCProtocol: class {
    
}



class YesOrNoPopUpVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var mainView: YesOrNoPopUpView!
    
    // MARK:- Properties
    private var viewModel: YesOrNoPopUpViewModelProtocol!
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setup(title: viewModel.getTitle())
        setYesAndNoActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.view.backgroundColor = ColorName.greyishBrown87.color.withAlphaComponent(0.87)
        })
    }

    // MARK:- Public Methods
    class func create(title: String) -> YesOrNoPopUpVC {
        let yesOrNoPopUpVC: YesOrNoPopUpVC = UIViewController.create(storyboardName: Storyboards.yesOrNoPopUp, identifier: ViewControllers.yesOrNoPopUpVC)
        yesOrNoPopUpVC.viewModel = YesOrNoPopUpViewModel(view: yesOrNoPopUpVC, title: title)
        return yesOrNoPopUpVC
    }
}

// MARK:- Private Methods
extension YesOrNoPopUpVC {
    private func setYesAndNoActions() {
        mainView.yesButton.addTarget(self, action: #selector(cancelAppointment), for: .touchUpInside)
        mainView.noButton.addTarget(self, action: #selector(dismissCurrent), for: .touchUpInside)
        
    }
    
    @objc private func cancelAppointment() {
        let topVC = self.presentingViewController
        dismiss(animated: true) {
            topVC?.dismissCurrent()
        }
    }
}

// MARK:- YesOrNoPopUpVC Protocol
extension YesOrNoPopUpVC: YesOrNoPopUpVCProtocol {
    
}
