//
//  SearchResults.swift
//  IDEHospital
//
//  Created by Ziad on 12/19/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

protocol SearchResultsVCProtocol: class {
    func showLoader()
    func hideLoader()
    func showAlert(title: String, message: String)
    func showSortType(_ sortType: String)
    func reloadData()
    func reloadToTop()
    func showNoDoctrosFoundLabel()
}

class SearchResultsVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var mainView: SearchResultsView!
    
    // MARK:- Properties
    private var viewModel: SearchResultsViewModelProtocol!
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setup()
        setupDelegates()
        setupNavigationItems()
        viewModel.searchForDoctors()
    }

    //MARK:- Public Methods
    class func create(with doctorsFilter: DoctorsFilter) -> SearchResultsVC {
        let searchResultsVC: SearchResultsVC = UIViewController.create(storyboardName: Storyboards.searchResults, identifier: ViewControllers.searchResultsVC)
        searchResultsVC.viewModel = SearchResultsViewModel(view: searchResultsVC, doctorsFilter: doctorsFilter)
        return searchResultsVC
    }
}


extension SearchResultsVC {
    // MARK:- Private Methods
    private func setupNavigationItems() {
        title = L10n.searchResults
        let backItem = UIBarButtonItem(image: Asset.back.image, style: .done, target: self, action: #selector(popUp))
        backItem.tintColor = ColorName.steelGrey.color
        let leftPadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftPadding.width = 18
        navigationItem.leftBarButtonItems = [leftPadding, backItem]
        let settingsItem = UIBarButtonItem(image: Asset.settings.image, style: .done, target: self, action: #selector(showSettings))
        settingsItem.tintColor = ColorName.steelGrey.color
        let rightPadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightPadding.width = 18
        navigationItem.rightBarButtonItems = [rightPadding, settingsItem]
    }
    
    private func setupDelegates() {
        mainView.sortTextField.delegate = self
        mainView.picker.delegate = self
        mainView.picker.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(UINib(nibName: Cells.searchResultsCell, bundle: nil), forCellReuseIdentifier: Cells.searchResultsCell)
    }
    
    // MARK:- Objc Methods
    @objc private func popUp() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func showSettings() {
        print("Show Settings")
    }
    
    @objc private func cancelTapped() {
        mainView.sortTextField.resignFirstResponder()
    }
    
    @objc private func doneTapped() {
        viewModel.sortTypeSelected(row: mainView.picker.selectedRow(inComponent: 0))
        mainView.sortTextField.resignFirstResponder()
    }
}

// MARK:- TextField Delegate
extension SearchResultsVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.addCancelDoneOnKeyboardWithTarget(self, cancelAction: #selector(cancelTapped), doneAction: #selector(doneTapped))
        return true
    }
}

// MARK:- PickerView Delegate
extension SearchResultsVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.getSortTypes().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.getSortTypes()[row]
    }
}

// MARK:- TableView Delegate
extension SearchResultsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainView.tableView.dequeueReusableCell(withIdentifier: Cells.searchResultsCell, for: indexPath) as! SearchResultsCell
        cell.delegate = self
        cell.configure(with: viewModel.getItem(for: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.mainView.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.willDisplay(indexPath.row)
    }
}

// MARK:- SearchResultsVC Protocol
extension SearchResultsVC: SearchResultsVCProtocol {
    func showLoader() {
        view.showActivityIndicator()
    }
    
    func hideLoader() {
        view.hideActivityIndicator()
    }
    
    func showAlert(title: String, message: String) {
        showSimpleAlert(title: title, message: message)
    }
    
    func showSortType(_ sortType: String) {
        DispatchQueue.main.async {
            self.mainView.sortTextField.text = sortType
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.mainView.tableView.reloadData()
        }
    }
    
    func reloadToTop() {
        let topIndex = IndexPath(row: 0, section: 0)
        DispatchQueue.main.async {
            self.mainView.tableView.reloadData()
            self.mainView.tableView.scrollToRow(at: topIndex, at: .top, animated: true)
        }
    }
    
    func showNoDoctrosFoundLabel() {
        DispatchQueue.main.async {
            self.mainView.showNoDoctorsFoundLabel()
        }
    }
}

//MARK:- Delegate Methods
extension SearchResultsVC: CellButtonDelegate {
    func bookNowAlert(customTableViewCell: UITableViewCell) {
        guard let indexPath = mainView.tableView.indexPath(for: customTableViewCell) else {return}
        viewModel.bookNowAlert(with: indexPath.row)
    }
    
    func addFavorite(customTableViewCell: UITableViewCell) {
        guard let indexPath = mainView.tableView.indexPath(for: customTableViewCell) else {return}
        viewModel.addRemoveFavorite(with: indexPath.row)
    }
}
