//
//  MainTabViewController.swift
//  Gank
//
//  Created by 魏星 on 16/7/16.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //设置导航栏标题颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //设置导航栏的前景色
        self.navigationController?.navigationBar.barTintColor = ThemeUtil.colorWithHexString(ThemeUtil.DARK_PRIMARY_COLOR)
        //
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let caption = UILabel();
        let frame = self.navigationController?.navigationBar.bounds;
        caption.frame = CGRectMake((frame?.origin.x)!, (frame?.origin.y)!, 20, (frame?.size.height)!)
        
        caption.text = "GANK.IO"
        caption.textColor = UIColor.whiteColor()
        caption.font = UIFont(name: "GillSans-Bold", size: 18)
        caption.sizeToFit()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: caption)
        self.title = "最新"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: tabBar
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        let title = item.title
        self.title = title
        print(title)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
