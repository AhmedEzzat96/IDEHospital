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
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Public Methods
    func setup() {
        setupBackground()
        setupLabel(label: viewLabel, text: "IDEA EG HOSPITAL THE BEST CHOICE", fontSize: 20)
        setupCollectionView()
    }
}

//MARK:- Private Methods
extension HomeView {
    private func setupBackground() {
        backgroundImgView.image = UIImage(named: "component22")
        logoImgView.image = UIImage(named: "group1")
        backgroundImgView.contentMode = .scaleAspectFill
        
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 150, height: 150)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
    }
    
    private func setupView(view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
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
