//
//  ViewDismiss.swift
//  ATAppFinder
//
//  Created by Geoffrey Johnson on 4/4/18.
//  Copyright © 2018 Geoffrey Johnson. All rights reserved.
//

import UIKit

/*  obj c version:
UIButton *transparencyButton = [[UIButton alloc] initWithFrame:superview.bounds];
transparencyButton.backgroundColor = [UIColor clearColor];
[superview insertSubview:transparencyButton belowSubview:helperView];
[transparencyButton addTarget:self action:@selector(dismissHelper:) forControlEvents:UIControlEventTouchUpInside];

- (void)dismissHelper:(UIButton *)sender
{
    [helperView dismiss];
    sender.hidden = YES;
    // or [sender removeFromSuperview]
}
*/

//class viewDismissTransparencyBtn: UIButton {
//    override var backgroundColor: UIColor? = UIColor.clear
//
//    override func awakeFromNib() {
//        setupView()
//    }
//
//    func setupView() {
//        self.addTarget(self, action: #selector(removeFromSuperview), for: .touchUpInside)
//    }
//}
