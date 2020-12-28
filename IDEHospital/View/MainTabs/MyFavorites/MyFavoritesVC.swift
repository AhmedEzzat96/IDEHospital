//
//  MyFavoritesVC.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 15/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

protocol MyFavoritesVCProtocol: class {
    func showLoader()
    func hideLoader()
    func reloadData()
    func isHidden(tableView: Bool, noItemsFound: Bool)
    func simpleAlert(title: String, message: String)
}

class MyFavoritesVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var myFavoritesView: MyFavoritesView!
    
    //MARK:- Properties
    private var viewModel: MyFavoritesViewModelProtocol!

    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        myFavoritesView.setup()
        tableViewConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadData()
    }
    
    //MARK:- Public Methods
    class func create() -> MyFavoritesVC {
        let myFavoritesVC: MyFavoritesVC = UIViewController.create(storyboardName: Storyboards.myFavorites, identifier: ViewControllers.myFavoritesVC)
        myFavoritesVC.viewModel = MyFavoritesViewModel(view: myFavoritesVC)
        return myFavoritesVC
    }
}

//MARK:- Private Methods
extension MyFavoritesVC {
    private func setupNavigationController() {
        setupNavController(title: L10n.myFavorites)
    }
    
    private func tableViewConfiguration() {
        myFavoritesView.tableView.delegate = self
        myFavoritesView.tableView.dataSource = self
        myFavoritesView.tableView.register(UINib(nibName: Cells.myFavoriteCell, bundle: nil), forCellReuseIdentifier: Cells.myFavoriteCell)
    }
}

//MARK:- MyFavoritesVC Protocol
extension MyFavoritesVC: MyFavoritesVCProtocol {
    func showLoader() {
        self.view.showActivityIndicator()
    }
    
    func hideLoader() {
        self.view.hideActivityIndicator()
    }
    
    func reloadData() {
        self.myFavoritesView.tableView.reloadData()
    }
    
    func isHidden(tableView: Bool, noItemsFound: Bool) {
        self.myFavoritesView.tableView.isHidden = tableView
        self.myFavoritesView.noFavoriteLabel.isHidden = noItemsFound
    }
    
    func simpleAlert(title: String, message: String) {
        self.showSimpleAlert(title: title, message: message)
    }
}

//MARK:- TableView Data Source
extension MyFavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getFavoriteItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myFavoritesView.tableView.dequeueReusableCell(withIdentifier: Cells.myFavoriteCell, for: indexPath) as? MyFavoriteCell else { return UITableViewCell() }
        cell.delegate = self
        cell.configureCell(viewModel.getItem(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.willDisplayCell(for: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 40
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 40
        }
    }
}

//MARK:- ShowAlert Delegate
extension MyFavoritesVC: CellButtonDelegate {
    func showDeleteAlert(customTableViewCell: UITableViewCell) {
        guard let indexPath = myFavoritesView.tableView.indexPath(for: customTableViewCell) else {return}
        viewModel.showDeleteAlert(with: indexPath.row)
    }
    
    func viewProfileAlert(customTableViewCell: UITableViewCell) {
        guard let indexPath = myFavoritesView.tableView.indexPath(for: customTableViewCell) else {return}
        viewModel.viewProfileAlert(with: indexPath.row)
    }
}
