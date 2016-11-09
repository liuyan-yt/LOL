//
//  InformationWebViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/15.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class InformationWebViewController: UIViewController {

    var url : NSURL = NSURL()
    var urlNight : NSURL = NSURL()
    let web : UIWebView = UIWebView()
    var more : UIButton = UIButton()
    var model = LastListModel()
    override func viewDidAppear(animated: Bool) {
        if NightModeManager.Singleton.sharedInstance.isNight == true {
            let request = NSURLRequest(URL: urlNight)
            self.web.loadRequest(request)
            self.view.backgroundColor = UIColor.blackColor()
        }
        else
        {
            let request = NSURLRequest(URL: url)
            self.web.loadRequest(request)
            self.view.backgroundColor = UIColor.whiteColor()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "掌游宝"
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "返回"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InformationWebViewController.leftAction));
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "收藏"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InformationWebViewController.collectionButtonAction));

        self.web.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-40)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InformationWebViewController.viewDidAppear(_:)), name: "reload", object: nil);
        self.view.addSubview(web)
        self.more.frame = CGRectMake(0,self.view.frame.size.height-40-64, self.view.frame.width, 40)
        self.more.addTarget(self, action: #selector(InformationWebViewController.moreAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.more.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.more.setTitle("更多精彩评论请查看！！！", forState: UIControlState.Normal);
        self.more.titleLabel?.textAlignment = NSTextAlignment.Right;
        self.more.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.more)

        
        
        // Do any additional setup after loading the view.
    }
    func collectionButtonAction(){
        print("收藏")
    }
    
    func leftAction(){
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    func moreAction(){
        let comment = InformationCommentViewController()
        comment.model = self.model
        self.navigationController?.pushViewController(comment, animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
