//
//  VideoDetailViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/16.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class VideoDetailViewController: UIViewController,UIGestureRecognizerDelegate {

    var id = String()
    var published = String()
    var str = String()
    let web : UIWebView = UIWebView()
    var button : UIButton = UIButton()
    var more : UIButton = UIButton()
    var play : UIView = UIView()
    var model : VideoDetailModel = VideoDetailModel()
    override func viewWillAppear(animated: Bool) {
        if NightModeManager.Singleton.sharedInstance.isNight == true {
            self.view.backgroundColor = UIColor.blackColor();
            self.buju();
        }else
        {
            self.view.backgroundColor = UIColor.whiteColor();
            self.buju();
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "掌游宝"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "返回"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(VideoDetailViewController.leftAction));
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VideoDetailViewController.viewWillAppear(_:)), name: "reload", object: nil);
        

        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func buju(){
        self.button = UIButton.init(type: UIButtonType.System)
        self.button.layer.borderColor = UIColor.blueColor().CGColor
        self.button.layer.borderWidth = 0.6
        self.button.frame = CGRectMake(0, 0, self.view.frame.size.width, 30)
        self.view.addSubview(self.button)
        self.button.setTitle("视频入口  >>", forState: UIControlState.Normal)
        self.button.addTarget(self, action: #selector(VideoDetailViewController.butttonAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.web.frame = CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height-40-64-30)
        self.view.addSubview(web)
        
        var str1 = videoDetailUrl1.stringByAppendingString(model.item_id)
        str1 = str1.stringByAppendingString(videoDetailUrl2)
        let url = NSURL.init(string: str1)
        var str2 = videoDetailUrl1.stringByAppendingString(model.item_id)
        str2 = str2.stringByAppendingString(videoDetailNight);
        let url2 = NSURL.init(string: str2)
        if NightModeManager.Singleton.sharedInstance.isNight == true {
            let request = NSURLRequest(URL: url2!)
            self.web.loadRequest(request)


        }else
        {
            let request = NSURLRequest(URL: url!)
            self.web.loadRequest(request)
            

        }
        
        
        
        
        self.more.frame = CGRectMake(0,self.view.frame.size.height-40-64, self.view.frame.width, 40)
        self.more.addTarget(self, action: #selector(VideoDetailViewController.moreAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.more.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.more.setTitle("更多精彩评论请查看！！！", forState: UIControlState.Normal);
        self.more.titleLabel?.textAlignment = NSTextAlignment.Right;
        
        self.view.addSubview(self.more)
    }
    
    
    func butttonAction(){
        let playVideo = VideoPlayViewController()
        playVideo.str = self.model.video_url
        self.navigationController?.pushViewController(playVideo, animated: true)
    }
    func moreAction(){
        let comment = VideoCommentViewController()
        comment.model = self.model
        self.navigationController?.pushViewController(comment, animated: true)
        
        
    }
    
    func leftAction(){
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
