//
//  MainTabBar.swift
//  IDEHospital
//
//  Created by Ziad on 12/10/20.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupNavigationItems()
        setupTabBarItems()
    }
}

extension MainTabBar {
    // MARK:- Private Methods
    private func setupNavigationItems() {
        navigationController?.navigationBar.barTintColor = UIColor(white: 204.0 / 255.0, alpha: 1.0)
        title = "Service Search"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let backItem = UIBarButtonItem(image: UIImage(named: "back2"), style: .done, target: self, action: #selector(popUp))
        backItem.tintColor = UIColor(red: 132.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
        let leftPadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftPadding.width = 18
        navigationItem.leftBarButtonItems = [leftPadding, backItem]
        let settingsItem = UIBarButtonItem(image: UIImage(named: "settings"), style: .done, target: self, action: #selector(showSettings))
        settingsItem.tintColor = UIColor(red: 132.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
        let rightPadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightPadding.width = 18
        navigationItem.rightBarButtonItems = [rightPadding, settingsItem]
    }
    
    private func setupTabBarItems() {
        self.tabBar.tintColor = .black
        let serviceSearchVC = ServiceSearchVC.create()
        serviceSearchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "Component 41 – 1"), tag: 1)
        
        let favoriteVC = UIViewController()
        favoriteVC.tabBarItem = UITabBarItem(title: "Favotire", image: UIImage(named: "heart"), tag: 2)
        
        let appointmentsVC = UIViewController()
        appointmentsVC.tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(named: "calendar-3"), tag: 3)
        self.viewControllers = [serviceSearchVC, favoriteVC, appointmentsVC]
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
            title = "Service Search"
        case 2:
            title = "MY FAVORITES"
        default:
            title = "MY APPOINTMENTS"
        }
    }
}
