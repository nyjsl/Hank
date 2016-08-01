//
//  VideoListViewController.swift
//  Gank
//
//  Created by 魏星 on 16/8/1.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

class VideoListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func buildController(title: String) -> VideoListViewController{
        let controller = ControllerUtils.loadViewControllerWithName(ControllerUtils.VCName.VCNameViewoList) as! VideoListViewController
        controller.title = title
        return controller
    }

}
