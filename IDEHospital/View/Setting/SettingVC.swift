//
//  SettingVC.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 28/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

protocol SettingVCProtocol: class {
    func goToLogin()
    func goToFavorites()
    func goToAppointment()
    func goToHome()
}

class SettingVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet var settingView: SettingView!
    
    //MARK:- Properties
    private var viewModel: SettingViewModelProtocol!
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        settingView.setup()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navController()
    }
    
    //MARK:- Public Methods
    class func create() -> SettingVC {
        let settingVC: SettingVC = UIViewController.create(storyboardName: Storyboards.setting, identifier: ViewControllers.settingVC)
        settingVC.viewModel = SettingViewModel(view: settingVC)
        settingVC.viewModel.configureModel()
        return settingVC
    }

}

//MARK:- Private Methods
extension SettingVC {
    private func setupTableView() {
        settingView.tableView.delegate = self
        settingView.tableView.dataSource = self
        settingView.tableView.register(UINib(nibName: Cells.settingCell, bundle: nil), forCellReuseIdentifier: Cells.settingCell)
    }
    
    private func navController() {
        setupNavController(title: L10n.settings, barTintColor: ColorName.darkRoyalBlue.color, fontColor: ColorName.white.color)
        setupNavigationItems(backAction: .dismissCurrent, isSettingEnable: false, tintColor: .white)
    }
}

//MARK:- TableView Data Source
extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settingCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingView.tableView.dequeueReusableCell(withIdentifier: Cells.settingCell) as! SettingCell
        cell.configure(data: viewModel.getSetting(for: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingView.tableView.deselectRow(at: indexPath, animated: false)
        viewModel.getSetting(for: indexPath.row).handler()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK:- SettingVC Protocol
extension SettingVC: SettingVCProtocol {
    func goToLogin() {
        let loginVC = LoginVC.create()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func goToFavorites() {
        let myFavoriteVC = MyFavoritesVC.create()
        myFavoriteVC.setupNavigationItems(backAction: .dismissCurrent, isSettingEnable: false)
        let myFavoriteNav = UINavigationController(rootViewController: myFavoriteVC)
        myFavoriteNav.modalPresentationStyle = .fullScreen
        present(myFavoriteNav, animated: true)
    }
    
    func goToAppointment() {
        let myAppointmentVC = MyAppointmentsVC.create()
        myAppointmentVC.setupNavigationItems(backAction: .dismissCurrent, isSettingEnable: false)
        let myAppointmentNav = UINavigationController(rootViewController: myAppointmentVC)
        myAppointmentNav.modalPresentationStyle = .fullScreen
        present(myAppointmentNav, animated: true)
    }
    
    func goToHome() {
        let window = AppDelegate.sharedInstance().window
        let homeVC = HomeVC.create()
        let homeNav = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = homeNav
    }
    
}
