//
//  SearchResultsView.swift
//  IDEHospital
//
//  Created by Ziad on 12/19/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class SearchResultsView: UIView {
    
    // MARK:- Outlets
    @IBOutlet weak var sortTextField: SortTextField!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Properties
    let picker = UIPickerView()
    
    // MARK:- Public Methods
    func setup() {
        setupBackground()
        setupTableView()
        setupSortTextField()
    }
    
    func showNoDoctorsFoundLabel() {
        let label = UILabel()
        label.frame.size = CGSize(width: self.bounds.width / 1.5, height: self.bounds.height / 10)
        label.center = self.center
        label.textAlignment = .center
        label.font = FontFamily.PTSans.bold.font(size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.text = L10n.noDoctorsFound
        DispatchQueue.main.async {
            self.addSubview(label)
        }
    }
}

// MARK:- Private Methods
extension SearchResultsView {
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
    private func setupSortTextField() {
        sortTextField.inputView = picker
    }
}
