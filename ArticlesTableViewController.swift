//
//  ArticlesTableViewController.swift
//  Gank
//
//  Created by 魏星 on 16/7/19.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit
import RxSwift
import MJRefresh

class ArticlesTableViewController: UITableViewController {
    
    var articleType: (String,String,String)?
    
    var dayArticlesModel = DayActiclesModel()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func setUpTableView(){
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .None
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { 
            self.refresh()
        })
        self.tableView.mj_header.executeRefreshingCallback()
    }
    
    func refresh(){
        dayArticlesModel.getArticlesByDay(articleType!.0, month: articleType!.1, day: articleType!.2).subscribe(onNext: { (entity) in
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                self.tableView.mj_header.endRefreshing()
            }, onDisposed: {
                print("onDisposed")
        }).addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let entity = dayArticlesModel.dayArticlesEntity{
            if let categor = entity.category{
                return categor.count > 0 ? categor.count : 0
            }
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let key = dayArticlesModel.dayArticlesEntity?.category![section]{
            let results = dayArticlesModel.dayArticlesEntity?.results![key]
            return (results?.count)!
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DayArticlesTableViewCell
        
        let category = dayArticlesModel.dayArticlesEntity?.category![indexPath.section]
        let articleEntity = dayArticlesModel.dayArticlesEntity?.results![category!]![indexPath.row]
        let desc = articleEntity!.desc ?? "未知"
        let who = articleEntity!.who ?? "佚名"
        cell.descLabel.text = desc
        cell.whoLabel.text = "via.\(who)"
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return dayArticlesModel.dayArticlesEntity?.category![section] ?? "未知"
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    static func buildController(ymd: (String,String,String)) -> ArticlesTableViewController{
        let controller = ControllerUtils.loadViewControllerWithName(ControllerUtils.VCName.VCNameArticlesTableView) as! ArticlesTableViewController
        controller.title = "\(ymd.0)/\(ymd.1)/\(ymd.2)"
        controller.articleType = ymd
        return controller
    }
}
