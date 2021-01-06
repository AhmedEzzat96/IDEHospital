//
//  SuccessOrFailurePopUpVC.swift
//  IDEHospital
//
//  Created by Ziad on 1/5/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit

protocol SuccessOrFailurePopUpVCProtocol: class {
    
}

enum PopUpType {
    case success(_ title: String)
    case failure(_ title: String)
}

enum OkButtonAction: String {
    case dismissCurrent
    case dismissCurrentAndPrevious
    case switchToHome
}

class SuccessOrFailurePopUpVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var mainView: SuccessOrFailurePopUpView!
    
    
    // MARK:- Properties
    private var viewModel: SuccessOrFailurePopUpViewModelProtocol!
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setup(viewModel.getImageAndTitle().0, title: viewModel.getImageAndTitle().1)
        setOkButtonTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.view.backgroundColor = ColorName.greyishBrown87.color.withAlphaComponent(0.87)
        })
    }
    
    // MARK:- Public Methods
    class func create(_ popUpType: PopUpType, okButtonAction: OkButtonAction) -> SuccessOrFailurePopUpVC {
        let successOrFailurePopUpVC: SuccessOrFailurePopUpVC = UIViewController.create(storyboardName: Storyboards.successOrFailurePopUp, identifier: ViewControllers.successOrFailurePopUpVC)
        successOrFailurePopUpVC.viewModel = SuccessOrFailurePopUpViewModel(view: successOrFailurePopUpVC, popUpType: popUpType, okButtonAction: okButtonAction)
        return successOrFailurePopUpVC
    }
}

extension SuccessOrFailurePopUpVC {
    // MARK:- Private Methods
    private func setOkButtonTarget() {
        mainView.okButton.addTarget(self, action: Selector(viewModel.getOkButtonAction()), for: .touchUpInside)
    }
    
    // MARK:- Objc Methods
    @objc private func dismissCurrentAndPrevious() {
        
    }
}

// MARK:- SuccessOrFailurePopUpVC Protocol
extension SuccessOrFailurePopUpVC: SuccessOrFailurePopUpVCProtocol {
    
}
