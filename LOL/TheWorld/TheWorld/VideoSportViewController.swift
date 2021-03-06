//
//  VideoSportViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/17.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class VideoSportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView = UITableView()
    var selfTitle = String()
    var id = String()
    var sport = 1
    lazy var videoDetailArray : [VideoDetailModel!] = [VideoDetailModel]()
    override func viewWillAppear(animated: Bool) {
        if NightModeManager.Singleton.sharedInstance.isNight == true
        {
            self.view.backgroundColor = UIColor.blackColor();
            self.tableView.reloadData();
        }else
        {
            self.view.backgroundColor = UIColor.whiteColor();
            self.tableView.reloadData();
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selfTitle;
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "返回"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(VideoSportViewController.leftAction))
        self.view.backgroundColor = UIColor.whiteColor()
        self.tableView = UITableView.init(frame:CGRectMake(0, -40, self.view.frame.size.width, self.view.frame.size.height), style: UITableViewStyle.Grouped)
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.registerClass(VideoListTableViewCell.self, forCellReuseIdentifier: "VideoListTableViewCell")
        self.view.addSubview(self.tableView)
        self.getData(1)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VideoTalkViewController.viewWillAppear(_:)), name: "reload", object: nil)
        self.tableView.backgroundColor = UIColor.clearColor();
        
    }
    func leftAction(){
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func getData(page:Int){
        
        let url = NSURL.init(string: videoSportListUrl1+self.id+videoSportListUrl2+String(page)+videoSportListUrl3)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if data != nil {
                
                let dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let array : NSMutableArray = dic["data"] as! NSMutableArray;
                for item in array {
                    let model = VideoDetailModel()
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                    self.videoDetailArray.append(model)
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
                
                
            }
        }
        task.resume()
        
        
        
    }
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.videoDetailArray.count;
        
    }
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("VideoListTableViewCell", forIndexPath: indexPath) as! VideoListTableViewCell;
        var model = VideoDetailModel();
        model = self.videoDetailArray[indexPath.row];
        cell.model = model;
        cell.title.numberOfLines = 0;
        cell.title.lineBreakMode = NSLineBreakMode.ByTruncatingTail;
        cell.title.font = UIFont.systemFontOfSize(18)
        let width = self.view.frame.size.width - CGRectGetMaxX(cell.pic_url.frame)-20-20
        let maximumLabelSize = CGSizeMake(width, 48.0);
        let expectsize = cell.title.sizeThatFits(maximumLabelSize)
        cell.title.frame = CGRectMake(CGRectGetMaxX(cell.pic_url.frame)+20, 20, expectsize.width, expectsize.height)
        cell.backgroundColor = UIColor.clearColor();
        
        return cell;
        
    }
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1;
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool){
        
        if (scrollView.contentOffset.y < 0) {
            self.getData(1)
        }else if(scrollView.contentOffset.y >= 0){
            self.sport = self.sport+1
            self.getData(self.sport)
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 120;
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let video = VideoDetailViewController();
        var model = VideoDetailModel()
        model = self.videoDetailArray[indexPath.row]
        video.model = model
        self.navigationController?.pushViewController(video, animated: true)
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
