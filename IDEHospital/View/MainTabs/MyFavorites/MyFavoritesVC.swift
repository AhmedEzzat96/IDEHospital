//
//  MyFavoritesVC.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 15/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

protocol MyFavoritesVCProtocol: class {
    
}

class MyFavoritesVC: UIViewController {
    
    //MARK:- Properties
    @IBOutlet weak var myFavoritesView: MyFavoritesView!
    var viewModel: MyFavoritesViewModelProtocol!

    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavController(title: L10n.myFavorites)
        myFavoritesView.setup()
        tableViewConfiguration()
    }
    
    //MARK:- Public Methods
    class func create() -> MyFavoritesVC {
        let myFavoritesVC: MyFavoritesVC = UIViewController.create(storyboardName: Storyboards.myFavorites, identifier: ViewControllers.myFavoritesVC)
        myFavoritesVC.viewModel = MyFavoritesViewModel(view: myFavoritesVC)
        return myFavoritesVC
    }
}

//MARK:- MyFavoritesVC Protocol
extension MyFavoritesVC: MyFavoritesVCProtocol {
    private func tableViewConfiguration() {
        myFavoritesView.tableView.delegate = self
        myFavoritesView.tableView.dataSource = self
        myFavoritesView.tableView.register(UINib(nibName: Cells.myFavoriteCell, bundle: nil), forCellReuseIdentifier: Cells.myFavoriteCell)
    }
}

//MARK:- TableView Data Source
extension MyFavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myFavoritesView.tableView.dequeueReusableCell(withIdentifier: Cells.myFavoriteCell, for: indexPath) as! MyFavoriteCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 245
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.myFavoritesView.tableView.deselectRow(at: indexPath, animated: true)
    }
}
