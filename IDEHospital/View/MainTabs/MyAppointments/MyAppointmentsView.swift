//
//  MyAppointmentsView.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 21/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class MyAppointmentsView: UIView {
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noAppointmentsLabel: UILabel!
    
    //MARK:- Public Methods
    func setup() {
        setupTableView()
        setupNoFavoriteLabel()
        setupBackground()
    }
}

//MARK:- Private Methods
extension MyAppointmentsView {
    private func setupTableView() {
        tableView.isHidden = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
    }
    
    private func setupNoFavoriteLabel() {
        noAppointmentsLabel.isHidden = true
        noAppointmentsLabel.textAlignment = .center
        noAppointmentsLabel.text = L10n.noAppointmentFound
        noAppointmentsLabel.font = FontFamily.PTSans.bold.font(size: 30)
        noAppointmentsLabel.textColor = ColorName.white.color
    }
}
