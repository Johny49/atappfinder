//
//  AppCVCell.swift
//  ATAppFinder
//
//  Created by Geoffrey Johnson on 2/20/18.
//  Copyright © 2018 Geoffrey Johnson. All rights reserved.
//

import UIKit

class AppCVCell: UICollectionViewCell {
    
    @IBOutlet weak var appImgView: UIImageView!
    @IBOutlet weak var appNameLbl: UILabel!
    
    var app: App!
//    var imageData: NSData!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ app: App) {
        
        appImgView.image = UIImage(named: "YATTI Logo 2")
        appNameLbl.text = app.name
//        self.app = app
//
//        print(app.name)
//        appNameLbl.text = self.app.name
//        self.appImgView.image = UIImage(data: self.app.appIcon as Data)!
        print("configCell")

    }
}
