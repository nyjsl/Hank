//
//  AboutViewController.swift
//  Gank
//
//  Created by 魏星 on 16/7/16.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    func setUpTableView(){
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .None
        
        tableView.showsVerticalScrollIndicator = false

        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let frame = tableView.frame;
        let y = frame.origin.y - 110
        let height = frame.size.height + 110
        tableView.frame = CGRectMake(frame.origin.x,y,frame.size.width,height);

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0{
            return CGFloat(270)
        }else{
            return tableView.rowHeight
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.HeaderIdentifier, forIndexPath: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.NOImgIdentifier, forIndexPath: indexPath) as! AboutNoImgCell
            cell.titleLabel.text = Titles.TitleIntroduce
            cell.contentLabel.text = Details.DetailIntroduce
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.ImgIdentifier, forIndexPath: indexPath) as! AboutImgCell
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.NOImgIdentifier, forIndexPath: indexPath) as! AboutNoImgCell
            cell.titleLabel.text = Titles.TitleLibs
            cell.contentLabel.text = Details.DetailLibs
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.NOImgIdentifier, forIndexPath: indexPath) as! AboutNoImgCell
            cell.titleLabel.text = "未知"
            cell.contentLabel.text = "未知"
            return cell
        }
    }
    
    
    struct CellIdentifier {
        static let HeaderIdentifier = "HeaderCell"
        static let ImgIdentifier = "CellWithImg"
        static let NOImgIdentifier = "CellNoImg"
    }
    
    struct Titles {
        static let TitleIntroduce = "介绍"
        static let TitleDevelopers = "开发人员"
        static let TitleLibs = "用到的开源库"
    }
    
    struct Details {
        static let DetailIntroduce = "这是一个奇怪的客户端\n\n数据内容来源于代码家的http://gank.io\n\n界面盗用模仿了好几个Gank.IO的客户端，有Android的也有IOS的，会感觉不伦不类\n\n用了不少的开源项目\n\n做的很粗糙，没有加错误界面～～"
        static let DetailDevelopers = "nyjsl"
        static let DetailLibs = "Alamofire\nCHTCollectionViewWaterfallLayout\nMoya\nRxSwift\nObjectMapper\nSDWebImage\nMJRefresh\nPageMenu\nIDMPhotoBrowser\nNJKWebViewProgress"

        
    }

}
