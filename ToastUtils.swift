//
//  ToastUtils.swift
//  Gank
//
//  Created by 魏星 on 16/7/25.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift
class ToastUtils{
    static let DefaultTipMsg = "网络错误，请稍后重试..."
    
    static let sharedInstance = ToastUtils()
    
    static func makeToast(view: UIView,msg: String = DefaultTipMsg){
        view.makeToast(msg, duration: 2, position: .Center)
    }
}