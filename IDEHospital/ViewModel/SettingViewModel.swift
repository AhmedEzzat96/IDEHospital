//
//  SettingViewModel.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 28/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import Foundation

protocol SettingViewModelProtocol {
    func settingCount() -> Int
    func configureModels()
    func getSetting(for index: Int) -> Setting
}

class SettingViewModel {
    //MARK:- Properties
    private var data = [[Setting]]()
    private weak var view: SettingVCProtocol?
    
    //MARK:- Init
    init(view: SettingVCProtocol) {
        self.view = view
    }
}

//MARK:- SettingViewModel Protocol
extension SettingViewModel: SettingViewModelProtocol {
    func configureModels() {
        var notAuthSetting = [Setting]()
        var authSetting = [Setting]()
        
        let login = Setting(title: L10n.login, icon: Asset.login.image) { [weak self] in
            self?.view?.goToLogin()
        }
        
        let aboutUs = Setting(title: L10n.aboutUs, icon: Asset.about.image) {
            print(L10n.aboutUs)
        }
        
        let contactUs = Setting(title: L10n.contactUs, icon: Asset.contact.image) {
            print(L10n.contactUs)
        }
        
        let share = Setting(title: L10n.share, icon: Asset.share.image) {
            print(L10n.share)
        }
        
        let terms = Setting(title: L10n.termsBtn, icon: Asset.terms.image) {
            print(L10n.termsBtn)
        }
        
        let editProfile = Setting(title: L10n.editProfile, icon: Asset.editProfile.image) {
            print(L10n.editProfile)
        }
        
        let favorites = Setting(title: L10n.favorites, icon: Asset.heart3.image) { [weak self] in
            self?.view?.goToFavorites()
        }
        
        let appointment = Setting(title: L10n.bookedAppointment, icon: Asset.calendar3.image) { [weak self] in
            self?.view?.goToAppointment()
        }
        
        let logout = Setting(title: L10n.logout, icon: Asset.logout.image) { [weak self] in
            UserDefaultsManager.shared().token = nil
            self?.view?.goToHome()
        }
        notAuthSetting = [login, aboutUs, contactUs, share, terms]
        authSetting = [editProfile, favorites, appointment, aboutUs, contactUs, share, terms, logout]
        data.append(notAuthSetting)
        data.append(authSetting)
    }
    
    func settingCount() -> Int {
        if UserDefaultsManager.shared().token != nil {
            return data[1].count
        } else {
            return data[0].count
        }
    }
    
    func getSetting(for index: Int) -> Setting {
        if UserDefaultsManager.shared().token != nil {
            return data[1][index]
        } else {
            return data[0][index]
        }
    }
}
