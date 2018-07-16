//
//  AuthorizeButton.swift
//  PhotoVK
//
//  Created by Konstantin Mishukov on 01.06.2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import UIKit

class AuthorizeButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 25, left: 25 , bottom: 25, right: 225)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 10)
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.buttonDarkGray : UIColor.buttonGray
        }
    }
    
}
