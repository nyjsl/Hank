//
//  RecentViewController.swift
//  Gank
//
//  Created by 魏星 on 16/7/16.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit
import RxSwift
import CHTCollectionViewWaterfallLayout
import SDWebImage
import MJRefresh
import IDMPhotoBrowser

class RecentViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let recentArticleModel = RecentArticlesModel()
    var disposeBag = DisposeBag()
    let whiteSpacing = CGFloat(8.0)
    
    
    @IBOutlet weak var articleCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registNibs()
        
        setUpCollectionView()
        
        self.articleCollectionView.mj_header.executeRefreshingCallback()
        // Do any additional setup after loading the view.
        
    }
    
    
    func setUpCollectionView(){
        
        self.articleCollectionView.dataSource = self
        self.articleCollectionView.delegate = self
        
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = whiteSpacing
        layout.minimumInteritemSpacing = whiteSpacing
        layout.sectionInset = UIEdgeInsetsMake(whiteSpacing, whiteSpacing, whiteSpacing, whiteSpacing)
        
        articleCollectionView.alwaysBounceVertical = true
        articleCollectionView.collectionViewLayout = layout
        articleCollectionView.backgroundColor = UIColor.whiteColor()
        
        articleCollectionView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            if self.articleCollectionView.mj_footer.isRefreshing(){
                self.articleCollectionView.mj_header.endRefreshing()
                return
            }
            
            self.recentArticleModel.refresh().subscribe(onNext: { (articles) in
                self.articleCollectionView.mj_footer.resetNoMoreData()
                self.articleCollectionView.reloadData()
                }, onError: { (error) in
                    print(error)
                    self.articleCollectionView.mj_header.endRefreshing()
                }, onCompleted: {
                    print("onComplted")
                     self.articleCollectionView.mj_header.endRefreshing()
                }, onDisposed: {
                    
            }).addDisposableTo(self.disposeBag)
            
        })
        
        self.articleCollectionView.mj_footer = MJRefreshAutoStateFooter.init {
            
            if self.articleCollectionView.mj_header.isRefreshing() {
                self.articleCollectionView.mj_footer.endRefreshing()
                return
            }
            
            self.recentArticleModel.loadMore().subscribe(onNext: { (entities) in
                if entities.isEmpty{
                    self.articleCollectionView.mj_footer.endRefreshingWithNoMoreData()
                }else{
                    self.articleCollectionView.mj_footer.endRefreshing()
                }
                self.articleCollectionView.reloadData()
                }, onError: { (error) in
                print(error)
                    self.articleCollectionView.mj_footer.endRefreshing()
                }, onCompleted: { 
                    print("onCompleted")
                }, onDisposed: { 
                    
            }).addDisposableTo(self.disposeBag)
        }
            self.articleCollectionView.mj_footer.hidden = true

    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        self.articleCollectionView.mj_footer.hidden = self.recentArticleModel.articleEntities.count == 0
        return recentArticleModel.articleEntities.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ArticleCollectionViewCell
        
        cell.backgroundColor = UIColor.whiteColor()
        let article = recentArticleModel.articleEntities[indexPath.item]
        cell.girlDescriptionLabel.text = article.desc!
        cell.girlImageView.clipsToBounds = true
       
        cell.girlImageView.setImageWithURL(NSURL(string: article.url!)!, placeholderImage: nil, options: .AvoidAutoSetImage) { (image, error, cacheType) in
                if nil == error{
                    cell.girlImageView.image = image
                    if cacheType == SDImageCacheType.None {
                        cell.girlImageView.alpha = 0
                        UIView.animateWithDuration(0.5, animations: {
                            cell.girlImageView.alpha = 1
                        })
                }else{
                     cell.girlImageView.alpha = 1
                }
            }
        }
        cell.girlImageView.tag = indexPath.item
        //响应事件
        cell.girlImageView.userInteractionEnabled = true
        
        let tagGustureReconginzer = UITapGestureRecognizer(target: self, action: #selector(actionImageTapped(_:)))
        cell.girlImageView.addGestureRecognizer(tagGustureReconginzer)
        cell.contentAnchorView.layer.cornerRadius = 3;
        cell.contentAnchorView.layer.masksToBounds = true
        
        //在self.layer上设置阴影
        RoundCornerUtils.drawRoundCornerToLayer(cell.layer)
//        cell.layer.cornerRadius = 3;
//        cell.layer.shadowColor = UIColor.darkGrayColor().CGColor;
//        cell.layer.masksToBounds = false;
//        cell.layer.shadowOffset = CGSizeMake(1, 1.5);
//        cell.layer.shadowRadius = 2;
//        cell.layer.shadowOpacity = 0.75;
//        cell.layer.shadowPath = UIBezierPath.init(roundedRect: cell.layer.bounds, cornerRadius: 3).CGPath
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let desc = self.recentArticleModel.articleEntities[indexPath.item].desc!
        
        let width = (articleCollectionView.bounds.width - whiteSpacing * 3) / 2
        let height = desc.heightWithConstrainedWidth(width, font: UIFont.systemFontOfSize(15))
        
        // height = img.height+ text.height + text.paddingTop
        return CGSize.init(width: width, height: width + height + 10.0)
    }

    
    //注册collectionView cell
    func registNibs(){
        let nibs = UINib(nibName: "ArticleCollectionViewCell", bundle: nil)
        articleCollectionView.registerNib(nibs, forCellWithReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func actionImageTapped(sender: UITapGestureRecognizer){
        if let view = sender.view as? UIImageView{
            let item = view.tag
            let article = recentArticleModel.articleEntities[item]
            if let url = article.url{
                
                let idmPhoto = IDMPhoto(URL: NSURL(string: url)!)
                idmPhoto.caption = article.desc
                let photoBrowser = IDMPhotoBrowser.init(photos: [idmPhoto], animatedFromView: sender.view)
                photoBrowser.usePopAnimation = true
                self.presentViewController(photoBrowser, animated: true, completion: nil)
            }

        }
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

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        
        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
