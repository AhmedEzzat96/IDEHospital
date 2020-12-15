//
//  HomeVC.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 08/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

protocol HomeVCProtocol: class {
    func showLoader()
    func hideLoader()
    func reloadCollectionView()
    func goToTabBar(with id: Int)
    func configureCell(for indexPath: IndexPath, categoryData: MainCategoriesData, image: UIImage)
}

class HomeVC: UIViewController {
    //MARK:- Properties
    var viewModel: HomeViewModelProtocol!
    
    //MARK:- IBOutlets
    @IBOutlet weak var homeView: HomeView!
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HomeViewModel(view: self)
        homeView.setup()
        viewModel.mainCategoriesData()
        setupNavController(title: L10n.chooseServices)
        setupCollectionView()
    }
    
    //MARK:- Public Methods
    class func create() -> HomeVC {
        let homeVC: HomeVC = UIViewController.create(storyboardName: Storyboards.home, identifier: ViewControllers.homeVC)
        return homeVC
    }
}

//MARK:- Private Methods
extension HomeVC {
    private func setupCollectionView() {
        homeView.collectionView.register(UINib.init(nibName: Cells.categoryCell, bundle: nil), forCellWithReuseIdentifier: Cells.categoryCell)
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
    }
}

//MARK:- HomeVC Protocol
extension HomeVC: HomeVCProtocol {
    func showLoader() {
        self.view.showActivityIndicator()
    }
    
    func hideLoader() {
        self.view.hideActivityIndicator()
    }
    
    func reloadCollectionView() {
        self.homeView.collectionView.reloadData()
    }
    
    func goToTabBar(with id: Int) {
        let tabBarVC = MainTabBar.create(with: id)
        self.navigationController?.pushViewController(tabBarVC, animated: true)
    }
    
    func configureCell(for indexPath: IndexPath, categoryData: MainCategoriesData, image: UIImage) {
        let cell = homeView.collectionView.cellForItem(at: indexPath) as! CategoryCell
        cell.configure(categoryData, image)
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
        viewModel.getCategoryData(for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.didSelectItem(item: indexPath.row)
    }
}
