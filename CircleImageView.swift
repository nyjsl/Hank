//
//  CircleImageView.swift
//  Gank
//
//  Created by 魏星 on 16/7/24.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImageView: UIImageView {
    
    @IBInspectable var borderWidth:CGFloat = 0.5
    
    @IBInspectable var raduisRatio:CGFloat = 0.5
    
    override func layoutSubviews() {
        layer.masksToBounds = true
        layer.cornerRadius = bounds.size.width * raduisRatio
        layer.borderWidth = borderWidth
        layer.borderColor = ThemeUtil.colorWithHexString(ThemeUtil.DARK_PRIMARY_COLOR).CGColor
    }
}
