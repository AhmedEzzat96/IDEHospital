//
//  MyAppointmentsVC.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 21/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

protocol MyAppointmentsVCProtocol: class {
    func showLoader()
    func hideLoader()
    func reloadData()
    func isHidden(tableView: Bool, noItemsFound: Bool)
    func showAlert(title: String, message: String, actions: [((UIAlertAction) -> Void)?]?)
}

class MyAppointmentsVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet var myAppointmentsView: MyAppointmentsView!
    
    //MARK:- Properties
    private var viewModel: MyAppointmentsViewModelProtocol!
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavController(title: L10n.myAppointments)
        myAppointmentsView.setup()
        tableViewConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadData()
    }

    //MARK:- Public Methods
    class func create() -> MyAppointmentsVC {
        let myAppointmentsVC: MyAppointmentsVC = UIViewController.create(storyboardName: Storyboards.myAppointments, identifier: ViewControllers.myAppointmentsVC)
        myAppointmentsVC.viewModel = MyAppointmentsViewModel(view: myAppointmentsVC)
        return myAppointmentsVC
    }
}

//MARK:- Private Methods
extension MyAppointmentsVC {
    private func tableViewConfiguration() {
        myAppointmentsView.tableView.delegate = self
        myAppointmentsView.tableView.dataSource = self
        myAppointmentsView.tableView.register(UINib(nibName: Cells.myAppointmentCell, bundle: nil), forCellReuseIdentifier: Cells.myAppointmentCell)
    }
}

//MARK:- TableView DataSource
extension MyAppointmentsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getFavoriteItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myAppointmentsView.tableView.dequeueReusableCell(withIdentifier: Cells.myAppointmentCell, for: indexPath) as? MyAppointmentCell else { return UITableViewCell() }
        cell.configureCell(viewModel.getItems()[indexPath.row])
        return cell
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.willDisplayCell(for: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.myAppointmentsView.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK:- MyAppointmentsVC Protocol
extension MyAppointmentsVC: MyAppointmentsVCProtocol {
    func showLoader() {
        self.view.showActivityIndicator()
    }
    
    func hideLoader() {
        self.view.hideActivityIndicator()
    }
    
    func reloadData() {
        self.myAppointmentsView.tableView.reloadData()
    }
    
    func isHidden(tableView: Bool, noItemsFound: Bool) {
        self.myAppointmentsView.tableView.isHidden = tableView
        self.myAppointmentsView.noAppointmentsLabel.isHidden = noItemsFound
    }
    
    func showAlert(title: String, message: String, actions: [((UIAlertAction) -> Void)?]?) {
        self.openAlert(title: title, message: message, alertStyle: .alert, actionTitles: ["No", "Yes"], actionStyles: [.cancel, .destructive], actions: actions)
    }
}
