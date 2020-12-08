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
        setupLabel(label: viewLabel, text: "IDEA EG HOSPITAL THE BEST CHOICE", fontSize: 20)
        setupLabel(label: humanMedicineLabel, text: "HUMAN MEDICINE")
        setupLabel(label: mriLabel, text: "MRI")
        setupLabel(label: homeNurseLabel, text: "HOME NURSE")
        setupLabel(label: veterinaryLabel, text: "VETERINARY")
        setupImage(imageView: logoImgView, image: "group1")
        setupImage(imageView: homeNurseImgView, image: "doctor2")
        setupImage(imageView: veterinaryImgView, image: "veterinary")
        setupImage(imageView: mriImgView, image: "ctScan")
        setupImage(imageView: humanMedicineImgView, image: "doctor")
    }
}

//MARK:- Private Methods
extension HomeView {
    private func setupBackground() {
        backgroundImgView.image = UIImage(named: "component22")
        backgroundImgView.contentMode = .scaleAspectFill
        humanMedicineView.backgroundColor = .black
        mriView.backgroundColor = .black
        homeNurseView.backgroundColor = .black
        veterinaryView.backgroundColor = .black
    }
    
    private func setupButtons() {
        mriButton.setTitle("", for: .normal)
        veterinaryButton.setTitle("", for: .normal)
        humanMedicineButton.setTitle("", for: .normal)
        homeNurseButton.setTitle("", for: .normal)
    }
    
    private func setupLabel(label: UILabel, text: String, fontSize: CGFloat = 15) {
        label.textAlignment = .center
        label.text = text
        label.textColor = .white
        label.font = UIFont(name: "PTSans-Bold", size: fontSize)
    }
    
    private func setupImage(imageView: UIImageView, image: String) {
        imageView.image = UIImage(named: image)
        imageView.contentMode = .scaleAspectFit
    }
    
}
