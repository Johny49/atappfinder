//
//  DetailsView.swift
//  ATAppFinder
//
//  Created by Geoffrey Johnson on 4/2/18.
//  Copyright © 2018 Geoffrey Johnson. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

@IBDesignable
class DetailsView: UIView {
    
    @IBOutlet weak var appImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var additionalInfoLbl: UILabel!
    @IBOutlet weak var itunesUrlLbl: UILabel!
    @IBOutlet weak var categoriesLbl: UILabel!
    
    @IBInspectable var cornerRadius: CGFloat = 12.0 {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).cgColor
        self.setNeedsLayout()
    }
    
    func configureApp(app: App) {
        
        nameLbl.text = app.name
        descriptionLbl.text = app.description
        additionalInfoLbl.text = app.moreInfo
        itunesUrlLbl.text = app.iTunesUrl
        categoriesLbl.text = app.categories

        Alamofire.request(app.appIconUrl).responseImage { response in
            debugPrint(response)
            
            print(response.request)
            print(response.response)
            debugPrint(response.result)
            
            if let image = response.result.value {
                self.appImgView.image = image
            }
        }

    }
}
