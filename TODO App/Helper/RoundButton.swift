//
//  ButtonHelper.swift
//  TODO App
//
//  Created by Marcin Kaliniak on 31/05/2019.
//  Copyright © 2019 Marcin Kaliniak. All rights reserved.
//
import UIKit

@IBDesignable class RoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    
    func sharedInit() {
        refreshCorners(value: cornerRadius)
    }
}
