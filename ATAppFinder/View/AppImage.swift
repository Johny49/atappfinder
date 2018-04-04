//
//  AppImage.swift
//  ATAppFinder
//
//  Created by Geoffrey Johnson on 4/2/18.
//  Copyright © 2018 Geoffrey Johnson. All rights reserved.
//

import UIKit

@IBDesignable
class AppImage: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 8.0 {
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
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
    }
}
