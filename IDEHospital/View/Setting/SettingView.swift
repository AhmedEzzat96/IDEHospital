//
//  SettingView.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 28/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class SettingView: UIView {
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Public Methods
    func setup() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = ColorName.veryLightPink.color
        tableView.isScrollEnabled = false
    }
}
