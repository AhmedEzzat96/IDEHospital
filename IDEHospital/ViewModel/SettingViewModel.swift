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
    func configureModel()
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

//MARK:- Private Methods
extension SettingViewModel {
    private func logout() {
        APIManager.logout { [weak self] (result) in
            switch result {
            case .success(let response):
                if response.code == 202 && response.success == true {
                    UserDefaultsManager.shared().token = nil
                    self?.view?.goToHome()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func logoutAlert() {
        self.view?.alertWithAction(title: L10n.logoutTitle, message: L10n.logoutMessage, handler: { [weak self] (alert) in
            self?.logout()
        })
    }
}

//MARK:- SettingViewModel Protocol
extension SettingViewModel: SettingViewModelProtocol {
    func configureModel() {
        var notAuthSetting = [Setting]()
        var authSetting = [Setting]()
        
        let login = Setting(title: L10n.login, icon: Asset.login.image) { [weak self] in
            self?.view?.goToLogin()
        }
        
        let aboutUs = Setting(title: L10n.aboutUs, icon: Asset.about.image) { [weak self] in
            self?.view?.goToAboutUsOrTerms(status: .aboutUs)
        }
        
        let contactUs = Setting(title: L10n.contactUs, icon: Asset.contact.image) { [weak self] in
            self?.view?.goToContactUs()
        }
        
        let share = Setting(title: L10n.share, icon: Asset.share.image) { [weak self] in
            self?.view?.goToShare()
        }
        
        let terms = Setting(title: L10n.termsBtn, icon: Asset.terms.image) { [weak self] in
            self?.view?.goToAboutUsOrTerms(status: .termsAndConditions)
        }
        
        let editProfile = Setting(title: L10n.editProfile, icon: Asset.editProfile.image) { [weak self] in
            self?.view?.showAlert(title: L10n.sorry, message: L10n.feature)
        }
        
        let favorites = Setting(title: L10n.favorites, icon: Asset.heart3.image) { [weak self] in
            self?.view?.goToFavorites()
        }
        
        let appointment = Setting(title: L10n.bookedAppointment, icon: Asset.calendar3.image) { [weak self] in
            self?.view?.goToAppointment()
        }
        
        let logout = Setting(title: L10n.logout, icon: Asset.logout.image) { [weak self] in
            self?.logoutAlert()
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
