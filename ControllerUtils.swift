//
//  ControllerUtils.swift
//  Gank
//
//  Created by 魏星 on 16/7/16.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit

class ControllerUtils{
    
    struct Identifiers{
        static let DEFAULT_SB_NAME = "Main"
    }
    
    struct VCName{
        static let VCNameMainTabBar = "MainTabBar";
        static let VCNameRecent = "Recent"
        static let VCNameSort = "Sort"
        static let VCNameAbout = "About"
        
        static let VCNameArticlesTableView = "Articles"
        
        static  let VCNameWebView = "WebView"
        
    }
    
    static func loadViewControllerWithName(vcName: String ,sbName: String = Identifiers.DEFAULT_SB_NAME) ->  UIViewController{
        let sb = UIStoryboard.init(name: sbName, bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier(vcName) as UIViewController
        return vc
    }
}
