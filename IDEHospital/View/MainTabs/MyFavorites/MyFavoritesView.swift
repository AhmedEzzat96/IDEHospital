//
//  MyFavoritesView.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 15/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class MyFavoritesView: UIView {
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noFavoriteLabel: UILabel!
    
    //MARK:- Public Methods
    func setup() {
        setupTableView()
        setupNoFavoriteLabel()
        setupBackground()
    }
}

//MARK:- Private Methods
extension MyFavoritesView {
    private func setupTableView() {
        tableView.isHidden = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
    }
    
    private func setupNoFavoriteLabel() {
        noFavoriteLabel.isHidden = true
        noFavoriteLabel.textAlignment = .center
        noFavoriteLabel.text = L10n.noFavoriteFound
        noFavoriteLabel.font = FontFamily.PTSans.bold.font(size: 30)
        noFavoriteLabel.textColor = ColorName.white.color
    }
}
