//
//  CommunityViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/11.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit
let Kheight : CGFloat = 250;
var Kwidth : CGFloat =  UIScreen.mainScreen().bounds.width;

class CommunityViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    override func viewDidAppear(animated: Bool) {
        
        if NightModeManager.Singleton.sharedInstance.isNight == true {
            self.view.backgroundColor = UIColor.blackColor();
//            self.tableViews.reloadData();
        }else
        {
            self.view.backgroundColor = UIColor.whiteColor();
//            self.tableViews.reloadData();
        }
    }
    let tableViews = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let size = AutoLayoutSize()
        size.size = 1.22;
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "个人"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CommunityViewController.personButtonAction(_:)));
        
        self.tableViews .registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell");
//        self.tableViews.backgroundColor = UIColor(red: 47.0/255.0, green: 50.0/255.0, blue: 58.0/255.0, alpha: 1);
        
        self.tableViews.frame = UIScreen.mainScreen().bounds;
        self.tableViews.delegate = self;
        self.tableViews.dataSource = self;
        self.tableViews.backgroundColor = UIColor.clearColor();
        self.view .addSubview(self.tableViews)
        
    }
    func personButtonAction(sender:UIBarButtonItem) -> Void {
        NSNotificationCenter.defaultCenter().postNotificationName("showleft", object: nil);
    }
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Kheight;
    }
    internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let showDetail = ShowDetailViewController()
        let friendDetail = FriendViewController()
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(showDetail, animated: true);
        }else
        {
            self.navigationController?.pushViewController(friendDetail, animated: true);
        }
        self.tableViews.deselectRowAtIndexPath(indexPath, animated: false);
        
        
    }
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath);
        if indexPath.row == 0 {
            var views = UIView();
            views = self.CreateFirstView();
            cell.contentView .addSubview(views);
            cell.backgroundColor = UIColor.clearColor();
            
            
            
        }else
        {
            cell.backgroundColor = UIColor.clearColor();
            var views = UIView();
            views = self.CreateSecondView();
            cell.contentView.addSubview(views);
            
            
            
        }
        cell.backgroundColor = UIColor.clearColor();
        return cell;
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func CreateFirstView() -> UIView {
        let views = UIView()
        views.backgroundColor = UIColor.whiteColor();
        views.frame = CGRectMake(10, 10, Kwidth - 20, Kheight - 20);
        let leftimageView = UIImageView.init(image: UIImage.init(named: "leftImage"));
        leftimageView.frame = CGRectMake(10, 5, 25, 25);
        let title = UILabel()
        title.frame = CGRectMake(37, leftimageView.center.y - 11, 60, 22);
        title.text = "真人秀";
        let enter = UILabel();
        enter.frame = CGRectMake(views.frame.size.width - 45, title.center.y - 11, 35, 22);
        enter.text = "进入"
        views.addSubview(leftimageView);
        views.addSubview(title);
        views.addSubview(enter);
        let bigImage = UIImageView();
        bigImage.frame = CGRectMake(10, 5 + 25, views.frame.size.width - 20, views.frame.size.height - 5-30-5);
        bigImage.image = UIImage.init(named: "女枪");
        views.addSubview(bigImage);
        view.backgroundColor = UIColor.clearColor();
        return views;
        
    }
    func CreateSecondView() -> UIView {
        let views = UIView()
        views.backgroundColor = UIColor.whiteColor();
        views.frame = CGRectMake(10, 10, Kwidth - 20, Kheight - 20);
        let leftimageView = UIImageView.init(image: UIImage.init(named: "leftImage"));
        leftimageView.frame = CGRectMake(10, 5, 25, 25);
        let title = UILabel()
        title.frame = CGRectMake(37, leftimageView.center.y - 11, 60, 22);
        title.text = "找战友";
        let enter = UILabel();
        enter.frame = CGRectMake(views.frame.size.width - 45, title.center.y - 11, 35, 22);
        enter.text = "进入"
        views.addSubview(leftimageView);
        views.addSubview(title);
        views.addSubview(enter);
        let bigImage = UIImageView();
        bigImage.frame = CGRectMake(10, 5 + 25, views.frame.size.width - 20, views.frame.size.height - 5-30-5);

        bigImage.image = UIImage.init(named: "男枪");
        views.addSubview(bigImage);
        
        return views;
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
