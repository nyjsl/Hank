//
//  RoundCornerUtils.swift
//  Gank
//
//  Created by 魏星 on 16/7/24.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit

class RoundCornerUtils{
    static func drawRoundCornerToLayer(layer: CALayer){
        
        layer.cornerRadius = 3;
        layer.shadowColor = UIColor.darkGrayColor().CGColor;
        layer.masksToBounds = false;
        layer.shadowOffset = CGSizeMake(1, 1.5);
        layer.shadowRadius = 2;
        layer.shadowOpacity = 0.75;
        layer.shadowPath = UIBezierPath.init(roundedRect: layer.bounds, cornerRadius: 3).CGPath

    }
    
    static func drawCircleImage(image: UIImageView){
        image.layer.masksToBounds = true
        image.layer.cornerRadius = image.bounds.size.width*0.5
        image.layer.borderWidth = CGFloat(0.5)
        image.layer.borderColor = ThemeUtil.colorWithHexString(ThemeUtil.DARK_PRIMARY_COLOR).CGColor
    }
}
