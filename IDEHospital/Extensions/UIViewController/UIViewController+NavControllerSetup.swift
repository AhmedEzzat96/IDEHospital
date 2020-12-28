//
//  UIViewController+NavControllerSetup.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 11/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    enum Back: String {
        case dismissCurrent
        case popUpCurrent
    }
    
    func setupNavController(title: String, barTintColor: UIColor = ColorName.veryLightPink.color, fontColor: UIColor = ColorName.white.color) {
        self.navigationItem.title = title
        self.navigationController?.navigationBar.clipsToBounds = true
        navigationController?.navigationBar.barTintColor = barTintColor
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : fontColor,
            NSAttributedString.Key.font: FontFamily.PTSans.bold.font(size: 20) as Any
        ]
    }
    
    func setupNavigationItems(backAction: Back, isSettingEnable: Bool = true, tintColor: UIColor = ColorName.steelGrey.color) {
        let backItem = UIBarButtonItem(image: Asset.back.image, style: .done, target: self, action: Selector(backAction.rawValue))
        backItem.tintColor = tintColor
        let leftPadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftPadding.width = 18
        navigationItem.leftBarButtonItems = [leftPadding, backItem]
        if isSettingEnable {
            let settingsItem = UIBarButtonItem(image: Asset.settings.image, style: .done, target: self, action: #selector(showSettings))
            settingsItem.tintColor = ColorName.steelGrey.color
            let rightPadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            rightPadding.width = 18
            navigationItem.rightBarButtonItems = [rightPadding, settingsItem]
        }
    }
    
    @objc func popUpCurrent() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissCurrent() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func showSettings() {
        let settingVC = SettingVC.create()
        let settingNav = UINavigationController(rootViewController: settingVC)
        settingNav.modalPresentationStyle = .fullScreen
        present(settingNav, animated: true)
    }
}

