//
//  ServiceSearchVC.swift
//  IDEHospital
//
//  Created by Ziad on 12/8/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class ServiceSearchVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var mainView: ServiceSearchView!
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setup()
    }
    
    // MARK:- Public Methods
    class func create() -> ServiceSearchVC {
        let serviceSearchVC: ServiceSearchVC = UIViewController.create(storyboardName: Storyboards.serviceSearch, identifier: ViewControllers.serviceSearchVC)
        return serviceSearchVC
    }
}

//extension ServiceSearchVC: UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 6
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return "Test"
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//    }
//}
