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
    @IBOutlet weak var additionalInfoLbl: UILabel!
    @IBOutlet weak var categoriesLbl: UILabel!
    @IBOutlet weak var detailsTV: UITextView!
    
    var currentApp: App!
    
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
        additionalInfoLbl.text = app.moreInfo
        categoriesLbl.text = app.categories
        
        detailsTV.text = app.description
        detailsTV.allowsEditingTextAttributes = false

        let placeholderImage = UIImage(named: "YATTI Logo 2")
        appImgView.af_setImage(withURL: URL(string: app.appIconUrl)!, placeholderImage: placeholderImage)
        
        currentApp = app
    }
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        let vc = self.window?.rootViewController
        
        let name = currentApp.name
        let url: URL = URL(string: currentApp.iTunesUrl)!
        
        print(name, url)
        
        let activityVC = UIActivityViewController(activityItems: [name,url], applicationActivities: nil)
        if let wPPC = activityVC.popoverPresentationController {
            wPPC.sourceView = self
        }
//        present(activityVC, animated: true)
        vc?.present(activityVC, animated: true, completion: {
            
        })
    }
    
    @IBAction func viewInAppStoreBtnPressed(_ sender: Any) {
        let url = URL(string: APP_STORE_BASE+currentApp.appID)!

        UIApplication.shared.open(url)
    }
    
}
