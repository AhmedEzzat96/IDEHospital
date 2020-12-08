//
//  HomeView.swift
//  IDEHospital
//
//  Created by Ahmed Ezzat on 08/12/2020.
//  Copyright © 2020 IDEAcademy. All rights reserved.
//

import UIKit

class HomeView: UIView {
    //MARK:- IBOutlets
    @IBOutlet weak var backgroundImgView: UIImageView!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var viewLabel: UILabel!
    
    @IBOutlet weak var humanMedicineView: UIView!
    @IBOutlet weak var humanMedicineImgView: UIImageView!
    @IBOutlet weak var humanMedicineLabel: UILabel!
    @IBOutlet weak var humanMedicineButton: UIButton!
    
    @IBOutlet weak var mriView: UIView!
    @IBOutlet weak var mriImgView: UIImageView!
    @IBOutlet weak var mriLabel: UILabel!
    @IBOutlet weak var mriButton: UIButton!
    
    @IBOutlet weak var homeNurseView: UIView!
    @IBOutlet weak var homeNurseImgView: UIImageView!
    @IBOutlet weak var homeNurseLabel: UILabel!
    @IBOutlet weak var homeNurseButton: UIButton!
    
    @IBOutlet weak var veterinaryView: UIView!
    @IBOutlet weak var veterinaryImgView: UIImageView!
    @IBOutlet weak var veterinaryLabel: UILabel!
    @IBOutlet weak var veterinaryButton: UIButton!
    
    //MARK:- Public Methods
    func setup() {
        setupBackground()
        setupButtons()
    }
}

//MARK:- Private Methods
extension HomeView {
    private func setupBackground() {
        backgroundImgView.image = UIImage(named: "component22")
        backgroundImgView.contentMode = .scaleAspectFill
    }
    
    private func setupButtons() {
        mriButton.setTitle("", for: .normal)
        veterinaryButton.setTitle("", for: .normal)
        humanMedicineButton.setTitle("", for: .normal)
        homeNurseButton.setTitle("", for: .normal)
    }
    
}
