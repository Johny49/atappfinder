//
//  AppCVCell.swift
//  ATAppFinder
//
//  Created by Geoffrey Johnson on 2/20/18.
//  Copyright © 2018 Geoffrey Johnson. All rights reserved.
//

import UIKit

class AppCVCell: UICollectionViewCell {
    
    @IBOutlet weak var appImgView: AppImage!
    @IBOutlet weak var appNameLbl: UILabel!
    
    var app: App!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ app: App) {
        
        if app.appIconUrl != "" {
            let placeholderImage = UIImage(named: "YATTI Logo 2")
            appImgView.af_setImage(withURL: URL(string: app.appIconUrl)!, placeholderImage: placeholderImage)
        } else {
            appImgView.image = UIImage(named: "YATTI Logo 2")
        }

        appNameLbl.text = app.name
    }
}
