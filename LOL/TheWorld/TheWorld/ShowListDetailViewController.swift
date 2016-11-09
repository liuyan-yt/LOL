//
//  ShowListDetailViewController.swift
//  TheWorld
//
//  Created by 原溢锴 on 16/8/17.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class ShowListDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableViews = UITableView();
    var models = CommunityModel();
    var dataArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViews = UITableView.init(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Grouped)

        tableViews.delegate = self;
        tableViews.dataSource = self;
        tableViews.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableViews)
        self.getData()
        self.tableViews.separatorStyle = UITableViewCellSeparatorStyle.None;
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count;
    }
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath);
        var view = UIView();
        view = self.createView(indexPath);
        cell.addSubview(view)
        
        return cell;
        
    }
    internal func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.mainScreen().bounds.size.height;
}
//    internal func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "玩家评论";
//    }
    internal func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let icon = UIImageView();
        let name = UILabel();
        let sex = UIImageView();
        let summoner = UILabel();
//        let time = UILabel();
        let bigImage = UIImageView()
        let script = UILabel();
//        let zan = UIImageView();
//        let zanCount = UILabel();
//        let comment = UIImageView()
//        let commentCount = UILabel();
        
        view.frame = UIScreen.mainScreen().bounds;
        icon.frame = CGRectMake(30, 20, 55, 55)
        icon.sd_setImageWithURL(NSURL.init(string: models.avatar));
        name.text = models.nickname;
        let maxSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 999);
        let expectSize = name.sizeThatFits(maxSize);
        name.frame = CGRectMake(CGRectGetMaxX(icon.frame) + 20, icon.frame.origin.y, expectSize.width, expectSize.height);
        sex.frame = CGRectMake(CGRectGetMaxX(name.frame) + 10, name.frame.origin.y, 20, 20);
        if models.sex == "1" {
            sex.image = UIImage.init(named: "男");
        }else
        {
            sex.image = UIImage.init(named: "女");
        }
        summoner.textColor = UIColor.lightGrayColor();
        summoner.text = "召唤师:(\(models.area))\(models.summoner)";
        let maxSize2 = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 999);
        let expectSize2 = summoner.sizeThatFits(maxSize2)
        summoner.frame = CGRectMake(name.frame.origin.x, CGRectGetMaxY(name.frame), expectSize2.width, expectSize2.height);
        bigImage.frame = CGRectMake(icon.frame.origin.x, CGRectGetMaxY(icon.frame) + 20, UIScreen.mainScreen().bounds.size.width - icon.frame.origin.x * 2,  UIScreen.mainScreen().bounds.size.width - icon.frame.origin.x * 2);
        bigImage.sd_setImageWithURL(NSURL.init(string: models.pic_url));
        script.text = models.desc;
        script.numberOfLines = 0;
        let maxSize3 = CGSizeMake(UIScreen.mainScreen().bounds.size.width - 40, 999);
        let expectSize3 = script.sizeThatFits(maxSize3);
        script.frame = CGRectMake(bigImage.frame.origin.x , CGRectGetMaxY(bigImage.frame) + 10, expectSize3.width, expectSize3.height);
        
        
        view.addSubview(icon)
        view.addSubview(name);
        view.addSubview(sex);
        view.addSubview(summoner);
        view.addSubview(bigImage);
        view.addSubview(script);
        
        
        
        
        
        
        
        return view;
    }
    
    func getData() -> Void {
        let url = NSURL.init(string: "\(communityShowDetailUrl1)\(models.id)\(communityShowDetailUrl2)")
        let session = NSURLSession.sharedSession();
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            var dict = NSMutableDictionary();
            dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSMutableDictionary
            let array : NSArray = dict["data"] as! NSArray;
            print(dict)
            for item in array {
                let model = CommunityCommentModel()
                
                model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                
                
                self.dataArray.addObject(model)
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableViews.reloadData();
            })
        }
        task.resume();
        

        
    }
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100;
    }
    func createView(indexPath:NSIndexPath) -> UIView {
        let model : CommunityCommentModel = dataArray[indexPath.row] as! CommunityCommentModel;
        
        let view = UIView()
        view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 100);
        let icon = UIImageView();
        let name = UILabel();
        let time = UILabel();
        let content = UILabel();
        let zan = UIImageView();
        let zanCount = UILabel();
        icon.frame = CGRectMake(20, 20, 40, 40);
        icon.layer.cornerRadius = 20;
        icon.layer.masksToBounds = true;
        icon.sd_setImageWithURL(NSURL.init(string: model.user_avatar));
        name.text = model.nickname;
        name.font = UIFont.systemFontOfSize(14);
        let maxSize = CGSizeMake(view.frame.size.width, 999);
        let expectSize = name.sizeThatFits(maxSize);
        name.frame = CGRectMake(CGRectGetMaxX(icon.frame) + 20, icon.frame.origin.y, expectSize.width, expectSize.height);
        time.font = UIFont.systemFontOfSize(14);
        time.frame = CGRectMake(name.frame.origin.x, CGRectGetMaxY(name.frame), 70, 20);
        time.text = model.created
        zan.frame = CGRectMake(view.frame.size.width - 70, name.frame.origin.y, 15, 15);
        zanCount.font = UIFont.systemFontOfSize(14);
        zanCount.frame = CGRectMake(CGRectGetMaxX(zan.frame), zan.frame.origin.y, 35, 20);
        zan.image = UIImage.init(named: "赞");
        zanCount.text = model.good;
        content.font = UIFont.systemFontOfSize(14);
        content.text = model.content;
        let  maxSize2 = CGSizeMake(view.frame.size.width - name.frame.origin.x - 10, 999);
        let expectSize2 = content.sizeThatFits(maxSize2);
        content.frame = CGRectMake(time.frame.origin.x, CGRectGetMaxY(time.frame) + 20, expectSize2.width, expectSize2.height);
        view.addSubview(icon);
        view.addSubview(name);
        view.addSubview(time);
        view.addSubview(content);
        view.addSubview(zanCount);
        view.addSubview(zan);
        return view;
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
