//
//  HomeVC.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 08/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit
import SDWebImage

protocol HomeVCProtocol: class {
    func showLoader()
    func hideLoader()
    func color(_ color: String) -> UIColor
    func reloadCollectionView()
    func getImage( imageView: UIImageView, imageUrl: String)
}

class HomeVC: UIViewController {
    //MARK:- Properties
    var viewModel: HomeViewModelProtocol!
    
    //MARK:- IBOutlets
    @IBOutlet weak var homeView: HomeView!
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.setup()
        viewModel.mainCategoriesData()
        setupNavController()
        setupCollectionView()
    }
    
    //MARK:- Public Methods
    class func create() -> HomeVC {
        let homeVC: HomeVC = UIViewController.create(storyboardName: Storyboards.home, identifier: ViewControllers.homeVC)
        homeVC.viewModel = HomeViewModel(view: homeVC)
        return homeVC
    }

    //MARK:- IBActions
    @IBAction func homeNurseBtnPressed(_ sender: UIButton) {
        print("Home Nurse")
    }
    
    @IBAction func veterinaryBtnPressed(_ sender: UIButton) {
        print("Veterinary")
    }
    
    @IBAction func mriBtnPressed(_ sender: UIButton) {
        print("MRI")
    }
    
    @IBAction func humanMedicineBtnPressed(_ sender: UIButton) {
        print("Human Medicine")
    }
}

//MARK:- Private Methods
extension HomeVC {
    private func setupNavController() {
        self.navigationItem.title = "Choose Services"
        self.navigationController?.navigationBar.clipsToBounds = true
        navigationController?.navigationBar.barTintColor = UIColor(white: 204 / 255, alpha: 1)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "PTSans-Bold", size: 20) as Any
        ]
    }
    
    private func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    private func setupCollectionView() {
        homeView.collectionView.register(UINib.init(nibName: Cells.categoryCell, bundle: nil), forCellWithReuseIdentifier: Cells.categoryCell)
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
    }
}

extension HomeVC: HomeVCProtocol {
    func showLoader() {
        self.view.showActivityIndicator()
    }
    
    func hideLoader() {
        self.view.hideActivityIndicator()
    }
    
    func color(_ color: String) -> UIColor {
        return UIColor(hexString: color)
    }
    
    func reloadCollectionView() {
        self.homeView.collectionView.reloadData()
    }
    
    func getImage( imageView: UIImageView, imageUrl: String) {
        imageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
    }
    
    
}

//MARK:- CollectionView Data Source
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCategoriesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.categoryCell, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        viewModel.configure(cell: cell, for: indexPath.row)
        return cell
    }
    
}
