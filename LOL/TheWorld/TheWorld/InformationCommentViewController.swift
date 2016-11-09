//
//  InformationCommentViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/25.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class InformationCommentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var heghtCell = CGFloat()
    var model : LastListModel = LastListModel()
    lazy var commentArray : [CommentModel!] = [CommentModel]()
    var comment = 1
    var tableView = UITableView()
    override func viewWillAppear(animated: Bool) {
        if NightModeManager.Singleton.sharedInstance.isNight == true {
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
        
        self.title = self.model.title
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "返回"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InformationCommentViewController.leftAction));
        self.view.backgroundColor = UIColor.whiteColor()
        self.tableView = UITableView.init(frame: CGRectMake(0, -40, self.view.frame.size.width, self.view.frame.size.height), style: UITableViewStyle.Grouped);
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(CommentTableViewCell.self, forCellReuseIdentifier: "CommentTableViewCell")
        self.view.addSubview(self.tableView)
        self.tableView.backgroundColor = UIColor.clearColor();
        self.getData(1)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InformationCommentViewController.viewWillAppear(_:)), name: "reload", object: nil);
    }
    func leftAction(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func getData(page:Int){
        let url = NSURL.init(string: videoCommentUrl1+String(self.model.id)+videoCommentUrl2+String(page)+videoCommentUrl3+String(self.model.id)+videoCommentUrl4)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if (data != nil) {
                let dic : NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let array = dic["data"] as! NSArray
                for item in array{
                    let model = CommentModel()
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                    self.commentArray.append(model)
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }
        task.resume()
        
        
    }
    
    
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return self.commentArray.count
        
        
    }
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentTableViewCell", forIndexPath: indexPath) as! CommentTableViewCell
        let model = self.commentArray[indexPath.row]
        cell.model = model
        
        cell.content.numberOfLines = 0;
        cell.content.lineBreakMode = NSLineBreakMode.ByTruncatingTail;
        cell.content.font = UIFont.systemFontOfSize(16)
        let width = cell.frame.width - CGRectGetMinX(cell.created.frame)-30
        let maximumLabelSize = CGSizeMake(width, 48.0);
        let expectsize = cell.content.sizeThatFits(maximumLabelSize)
        cell.content.frame = CGRectMake(CGRectGetMinX(cell.created.frame),CGRectGetMaxY(cell.created.frame)+5, expectsize.width, expectsize.height)
        cell.toNickname.numberOfLines = 0;
        cell.toNickname.lineBreakMode = NSLineBreakMode.ByTruncatingTail;
        cell.toNickname.font = UIFont.systemFontOfSize(14)
        let width1 : CGFloat = 300.0
        let maximumLabelSize1 = CGSizeMake(width1, 48.0);
        let expectsize1 = cell.toNickname.sizeThatFits(maximumLabelSize1)
        cell.toNickname.frame = CGRectMake(10, 0,  expectsize1.width, expectsize1.height)
        cell.toContent.numberOfLines = 0;
        cell.toContent.lineBreakMode = NSLineBreakMode.ByTruncatingTail;
        cell.toContent.font = UIFont.systemFontOfSize(16)
        let width2 : CGFloat = 300.0
        let maximumLabelSize2 = CGSizeMake(width2, 48.0);
        let expectsize2 = cell.toContent.sizeThatFits(maximumLabelSize2)
        cell.toContent.frame = CGRectMake(CGRectGetMinX(cell.toNickname.frame), CGRectGetMaxY(cell.toNickname.frame), expectsize2.width, expectsize2.height)
        cell.to.frame = CGRectMake(CGRectGetMinX(cell.content.frame), CGRectGetMaxY(cell.content.frame)+5, cell.frame.width-CGRectGetMinX(cell.content.frame)-20, CGRectGetMaxY(cell.toContent.frame))
        self.heghtCell = CGRectGetMaxY(cell.to.frame)+20
        cell.backgroundColor = UIColor.clearColor();
        return cell
        
    }
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        
        return 1;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return self.heghtCell;
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool){
        
        if (scrollView.contentOffset.y < 0) {
            self.getData(1)
        }else if(scrollView.contentOffset.y >= 0){
            self.comment = self.comment+1
            self.getData(self.comment)
        }
    }


}
