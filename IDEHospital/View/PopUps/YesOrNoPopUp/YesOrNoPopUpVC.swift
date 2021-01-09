//
//  YesOrNoPopUpVC.swift
//  IDEHospital
//
//  Created by Ziad on 1/5/21.
//  Copyright © 2021 IDEAcademy. All rights reserved.
//

import UIKit

protocol YesOrNoPopUpVCDelegate: class {
    func yesPressed()
}

class YesOrNoPopUpVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var mainView: YesOrNoPopUpView!
    
    // MARK:- Properties
    private var popUpTitle: String!
    weak var delegate: YesOrNoPopUpVCDelegate?
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setup(title: popUpTitle)
        setYesAndNoActions()
    }

    // MARK:- Public Methods
    class func create(title: String) -> YesOrNoPopUpVC {
        let yesOrNoPopUpVC: YesOrNoPopUpVC = UIViewController.create(storyboardName: Storyboards.yesOrNoPopUp, identifier: ViewControllers.yesOrNoPopUpVC)
        yesOrNoPopUpVC.popUpTitle = title
        return yesOrNoPopUpVC
    }
}

extension YesOrNoPopUpVC {
    // MARK:- Private Methods
    private func setYesAndNoActions() {
        mainView.yesButton.addTarget(self, action: #selector(yesPressed), for: .touchUpInside)
        mainView.noButton.addTarget(self, action: #selector(dismissCurrent), for: .touchUpInside)
    }
    
    // MARK:- Objc Methods
    @objc private func yesPressed() {
        dismiss(animated: true) {
            self.delegate?.yesPressed()
        }
    }
}
