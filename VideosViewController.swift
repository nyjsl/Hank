//
//  VideosViewController.swift
//  Gank
//
//  Created by 魏星 on 16/7/26.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

import RxSwift
import PageMenu

class VideosViewController: UIViewController {
    
    var pageMenu: CAPSPageMenu?
    
    var categoriesModel: CategoryModel?
    var disposdBag = DisposeBag()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesModel = CategoryModel()
        
        activityIndicator.startAnimating()
        
        
        categoriesModel?.getCategories().subscribe(onNext: { (entites) in
            print(entites)
            self.setUpPageMenu(entites)
            }, onError: { (error) in
                self.activityIndicator.stopAnimating()
                ToastUtils.makeToast(self.view)
            }, onCompleted: {
                self.activityIndicator.stopAnimating()
                print("onCompleted")
            }, onDisposed: { 
                print("onDisosed")
        }).addDisposableTo(disposdBag)
    }
    
    private func setUpPageMenu(entities: [CategoryEntity]){
        
        var controllers:[UIViewController] = []
        
        for e in entities.enumerate(){
            let entity = e.element
            controllers.append(VideoListViewController.buildController(entity.name!))
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
