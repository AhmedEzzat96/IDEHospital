//
//  MainTabBar.swift
//  IDEHospital
//
//  Created by Ziad on 12/10/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {

    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupNavigationItems()
        setupNavController(title: L10n.serviceSearch)
        setupTabBar()
    }
    
    // MARK:- Public Methods
    class func create(with categoryID: Int) -> MainTabBar {
        let mainTabBar = MainTabBar()
        let serviceSearchVC = mainTabBar.createServiceSearchVC(with: categoryID)
        let favoriteVC = mainTabBar.createFavoriteVC()
        let appointmentsVC = mainTabBar.createAppointmentsVC()
        mainTabBar.viewControllers = [serviceSearchVC, favoriteVC, appointmentsVC]
        return mainTabBar
    }
}

extension MainTabBar {
    // MARK:- Private Methods
    private func setupNavigationItems() {
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
    
    private func setupTabBar() {
        self.tabBar.backgroundColor = ColorName.whiteTwo.color
        self.tabBar.tintColor = ColorName.blackTwo.color
    }
    
    private func createServiceSearchVC(with categoryID: Int) -> ServiceSearchVC {
        let serviceSearchVC = ServiceSearchVC.create(with: categoryID)
        serviceSearchVC.tabBarItem = UITabBarItem(title: L10n.search, image: Asset.search.image, tag: 1)
        return serviceSearchVC
    }
    
    private func createFavoriteVC() -> UIViewController {
        let favoriteVC = MyFavoritesVC.create()
        favoriteVC.tabBarItem = UITabBarItem(title: L10n.favorite, image: Asset.heart.image, tag: 2)
        return favoriteVC
    }
    
    private func createAppointmentsVC() -> UIViewController {
        let appointmentsVC = MyAppointmentsVC.create()
        appointmentsVC.tabBarItem = UITabBarItem(title: L10n.schedule, image: Asset.calendar.image, tag: 3)
        return appointmentsVC
    }
    
    // MARK:- Objc Methods
    @objc private func popUp() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func showSettings() {
        print("Show Settings")
    }
    
}

// MARK:- TabBar Delegate
extension MainTabBar: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            title = L10n.serviceSearch
        case 2:
            title = L10n.myFavorites
        default:
            title = L10n.myAppointments
        }
    }
}
