//
//  SortViewController.swift
//  Gank
//
//  Created by 魏星 on 16/7/16.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit
import PageMenu

class SortViewController: UIViewController {
    
    
    var pageMenu: CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPageMenu()
    }
    
    
    func setUpPageMenu(){
//        var controllers = [UIViewController]()
        var controllers: [UIViewController] = []
        
        for type in DateUtils.getYMDTupleArray(){
            let controller = ArticlesTableViewController.buildController(type)
            controllers.append(controller)
        }
        
        let y = UIApplication.sharedApplication().statusBarFrame.height + (self.navigationController?.navigationBar.frame.height)!
        
        let parent = self.parentViewController as! UITabBarController
        
        let pageMenuOption: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor.whiteColor()),
            .ViewBackgroundColor(UIColor.whiteColor()),
            .MenuItemSeparatorColor(ThemeUtil.colorWithHexString(ThemeUtil.DARK_PRIMARY_COLOR)),
            .SelectionIndicatorColor(ThemeUtil.colorWithHexString(ThemeUtil.DARK_PRIMARY_COLOR)),
            .SelectedMenuItemLabelColor(ThemeUtil.colorWithHexString(ThemeUtil.DARK_PRIMARY_COLOR))
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllers, frame: CGRectMake(0.0, y, self.view.frame.width, self.view.frame.height - y - parent.tabBar.frame.size.height), pageMenuOptions: pageMenuOption)
        
          self.view.addSubview(pageMenu!.view)
    }

}
