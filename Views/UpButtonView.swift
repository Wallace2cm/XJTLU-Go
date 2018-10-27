//
//  UpButtonView.swift
//  XJTLU
//
//  Created by Wallace Wu on 2018/5/5.
//  Copyright © 2018年 Wallace Wu. All rights reserved.
//

import UIKit
@IBDesignable

class UpButtonView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
