//
//  VideosViewController.swift
//  Gank
//
//  Created by 魏星 on 16/7/26.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

import RxSwift
class VideosViewController: UIViewController {
    
    var categoriesModel: CategoryModel?
    var disposdBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesModel = CategoryModel()
        
        categoriesModel?.getCategories().subscribe(onNext: { (entites) in
            print(entites)
            }, onError: { (error) in
                ToastUtils.makeToast(self.view)
            }, onCompleted: { 
                print("onCompleted")
            }, onDisposed: { 
                print("onDisosed")
        }).addDisposableTo(disposdBag)
    }
    
}
