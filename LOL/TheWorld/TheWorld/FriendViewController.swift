//
//  FriendViewController.swift
//  TheWorld
//
//  Created by 原溢锴 on 16/8/16.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let tableViews = UITableView()
    var modelArrays = NSMutableArray()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViews.frame = UIScreen.mainScreen().bounds;
        tableViews.delegate = self;
        tableViews.dataSource = self;
        tableViews.separatorStyle = UITableViewCellSeparatorStyle.None;
        self.view.backgroundColor = UIColor.whiteColor();
        self.view.addSubview(self.tableViews);
        self.getData();
        self.tableViews.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
    }
    func creatView(indexPath:NSIndexPath) -> UIView {
        var model = FriendListModel()
        model = modelArrays[indexPath.row] as! FriendListModel;
        
        let view = UIView();
        let icon = UIImageView();
        let name = UILabel();
        let sex = UIImageView();
        let summoner = UILabel();
        let fightScore = UILabel();
//        let timeLabel = UILabel()
        let devide1 = UIView();
        let voice = UILabel();
        let city = UILabel();
        let declaration = UILabel();
        let devide2 = UIView();
        let zan = UIImageView();
        let zanCount = UILabel();
        let comment = UIImageView();
        let commentCount = UILabel();
        view.frame = CGRectMake(10, 5, UIScreen.mainScreen().bounds.size.width - 20, UIScreen.mainScreen().bounds.size.height/3);
        icon.frame = CGRectMake(10, 10, 55, 55);
        icon.backgroundColor = UIColor.greenColor();
        icon.layer.cornerRadius = 55/2;
        icon.layer.masksToBounds = true;
        name.frame = CGRectMake(icon.frame.origin.x + icon.frame.size.width + 5, icon.frame.origin.y, 10, 10);
        name.font = UIFont.systemFontOfSize(14);
        name.textAlignment = NSTextAlignment.Center;
        name.numberOfLines = 0;
        name.text = model.nickname
        let maxiumLabel = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 999);
        let expectSize = name.sizeThatFits(maxiumLabel)
        name.frame = CGRectMake(icon.frame.origin.x + icon.frame.size.width + 5, icon.frame.origin.y, expectSize.width, expectSize.height);
        
        sex.frame = CGRectMake(CGRectGetMaxX(name.frame) + 5, name.frame.origin.y, 20, 20)
        if model.sex == "1" {
            sex.image = UIImage.init(named: "男")
        }else
        {
            sex.image = UIImage.init(named: "女")
        }
        summoner.frame = CGRectMake(name.frame.origin.x,CGRectGetMaxY(name.frame), 10, 10);
        summoner.text = "召唤师:(\(model.area))\(model.summoner)"
        summoner.font = UIFont.systemFontOfSize(14);
        let expectSize2 = summoner.sizeThatFits(maxiumLabel);
        summoner.frame = CGRectMake(name.frame.origin.x, CGRectGetMaxY(name.frame) + 5, expectSize2.width, expectSize2.height);
        fightScore.frame = CGRectMake(summoner.frame.origin.x, CGRectGetMaxY(summoner.frame), 10, 10);
        fightScore.numberOfLines = 0;
        fightScore.font = UIFont.systemFontOfSize(14);
        fightScore.text = "战斗力:\(model.zdl)"
        let expectSize3 = fightScore.sizeThatFits(maxiumLabel);
        fightScore.frame = CGRectMake(summoner.frame.origin.x, CGRectGetMaxY(summoner.frame), expectSize3.width, expectSize3.height);
        devide1.frame = CGRectMake(0, CGRectGetMaxY(icon.frame) + 5, view.frame.size.width, 1);
        devide1.backgroundColor = UIColor.lightGrayColor();
        voice.frame = CGRectMake(icon.frame.origin.x, CGRectGetMaxY(devide1.frame) + 30, 10, 10);
        if model.enable_voice == "0" {
            voice.text = "开黑语音:不确定"
        }else if model.enable_voice == "1"
        {
            voice.text = "开黑语音:不愿意"
        }else
        {
            voice.text = "开黑语音:好啊好啊"
        }
        let maxiumLabel2 = CGSizeMake(view.frame.size.width, 999);
        let expectSize4 = voice.sizeThatFits(maxiumLabel2);
        voice.font = UIFont.systemFontOfSize(14)
        voice.frame = CGRectMake(icon.frame.origin.x, CGRectGetMaxY(devide1.frame) + 30, expectSize4.width, expectSize4.height);
        
        city.font = UIFont.systemFontOfSize(14);
        if model.city == "null" {
            city.text = "所在城市:未知"
        }else
        {
            city.text = "所在城市:\(model.city)";
        }
        let expectSize5 = city.sizeThatFits(maxiumLabel);
        city.frame = CGRectMake(voice.frame.origin.x, CGRectGetMaxY(voice.frame), expectSize5.width, expectSize5.height);
        declaration.text = "约战宣言:\(model.slogan)";
        declaration.font = UIFont.systemFontOfSize(14);
        let expectSize6 = declaration.sizeThatFits(maxiumLabel);
        declaration.frame = CGRectMake(city.frame.origin.x, CGRectGetMaxY(city.frame), expectSize6.width, expectSize6.height)
        devide2.frame = CGRectMake(0, CGRectGetMaxY(declaration.frame) + 20, view.frame.size.width, 1);
        devide2.backgroundColor = UIColor.lightGrayColor()
        zan.frame = CGRectMake(view.frame.size.width/4 * 3,CGRectGetMaxY(devide2.frame) + 10, 15, 15);
        zan.image = UIImage.init(named: "赞")
        zanCount.frame = CGRectMake(CGRectGetMaxX(zan.frame) + 5, zan.frame.origin.y, 20, 15);
        zanCount.text = model.good;
        comment.frame = CGRectMake(CGRectGetMaxX(zanCount.frame), zanCount.frame.origin.y, 15, 15);
        comment.image = UIImage.init(named: "评论")
        commentCount.frame = CGRectMake(CGRectGetMaxX(comment.frame) + 5, comment.frame.origin.y, 20, 15);
        commentCount.text = model.comment;
        icon.sd_setImageWithURL(NSURL.init(string: model.avatar))
        view.addSubview(icon);
        view.addSubview(name);
        view.addSubview(sex);
        view.addSubview(summoner);
        view.addSubview(fightScore);
        view.addSubview(devide1);
        view.addSubview(voice);
        view.addSubview(city);
        view.addSubview(declaration);
        view.addSubview(devide2);
        view.addSubview(zan);
        view.addSubview(zanCount);
        view.addSubview(comment);
        view.addSubview(commentCount);
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = true;
        view.backgroundColor = UIColor.whiteColor();
        
        
        
        
        return view;
        
    }
    func getData() -> Void {
        let url = NSURL.init(string: communityFriendUrl)
        let session = NSURLSession.sharedSession();
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            var dict = NSMutableDictionary();
            dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSMutableDictionary
            let array : NSMutableArray = dict["data"] as! NSMutableArray;
            
            for item in array {
                let model = FriendListModel()
                
                model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                
                
                self.modelArrays.addObject(model)
            }
            dispatch_async(dispatch_get_main_queue(), { 
                self.tableViews.reloadData();
            })
        }
        task.resume();
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//==============================================================================================================
//===============================================tableView方法===========================================================
//==============================================================================================================
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArrays.count
    }
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        var view = UIView()
        
        view = self.creatView(indexPath)
        cell.addSubview(view)
        cell.backgroundColor = UIColor.blackColor();
        return cell;
        
    }
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UIScreen.mainScreen().bounds.size.height/3 + 10;
    }
    internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false);
        let view = FriendDetailTableViewController();
        view.modal = modelArrays[indexPath.row] as! FriendListModel;
        self.navigationController?.pushViewController(view, animated: true);
        
    }
}
