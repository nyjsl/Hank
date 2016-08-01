//
//  WebViewController.swift
//  Gank
//
//  Created by 魏星 on 16/7/24.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit
import NJKWebViewProgress

class WebViewController: UIViewController ,UIWebViewDelegate,NJKWebViewProgressDelegate{
    
    var articleEntity: ArticleEntity?
    
    var webViewProgress: NJKWebViewProgress?
    
    var webViewProgressView: NJKWebViewProgressView?
    
    let ProgressWiewHeight = CGFloat(2)

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWebviewProgressView()
        // Do any additional setup after loading the view.
    }
    
    func setUpWebviewProgressView(){
        
        self.title = articleEntity?.desc
        
        let bouds = self.navigationController?.navigationBar.bounds
        let x = bouds!.width
        let y = (bouds?.height)! - ProgressWiewHeight
        let frame = CGRectMake(x, y, x , ProgressWiewHeight)
        
        webViewProgressView = NJKWebViewProgressView(frame: frame)
        webViewProgressView?.progressBarView.backgroundColor = ThemeUtil.colorWithHexString(ThemeUtil.DARK_PRIMARY_COLOR)
        
        webViewProgress = NJKWebViewProgress()
        webViewProgress?.progressDelegate = self
        webViewProgress?.webViewProxyDelegate = self
        webView.delegate = webViewProgress
        
        webView.loadRequest(NSURLRequest(URL: NSURL(string: (articleEntity?.url)!)!))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.addSubview(webViewProgressView!)
       
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        webViewProgressView?.removeFromSuperview()
    }
    

    func webViewProgress(webViewProgress: NJKWebViewProgress!, updateProgress progress: Float) {
        webViewProgressView?.setProgress(progress, animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    static func buildViewController(article: ArticleEntity) -> WebViewController{
        let controller = ControllerUtils.loadViewControllerWithName(ControllerUtils.VCName.VCNameWebView) as! WebViewController
        controller.articleEntity = article
        return controller
    }
}
