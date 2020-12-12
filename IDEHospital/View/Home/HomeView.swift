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
        self.setupBackground()
        setupLabel(label: viewLabel, text: "IDEA EG HOSPITAL THE BEST CHOICE", fontSize: 20)
        setupCollectionView()
        setupLogoImgView()
    }
}

//MARK:- Private Methods
extension HomeView {
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.frame.size.width/2.5, height: self.frame.size.width/2.5)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
    }
    
    private func setupLogoImgView() {
        logoImgView.image = Asset.group1.image
    }
    
    private func setupView(view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
    }
    
    private func setupLabel(label: UILabel, text: String, fontSize: CGFloat = 15) {
        label.textAlignment = .center
        label.text = text
        label.textColor = ColorName.white.color
        label.font = FontFamily.PTSans.bold.font(size: fontSize)
    }
    
    private func setupImage(imageView: UIImageView, image: String) {
        imageView.image = UIImage(named: image)
        imageView.contentMode = .scaleAspectFit
    }
    
}
