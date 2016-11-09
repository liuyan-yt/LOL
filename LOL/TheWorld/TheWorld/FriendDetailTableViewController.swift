//
//  FriendDetailTableViewController.swift
//  TheWorld
//
//  Created by 原溢锴 on 16/8/18.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class FriendDetailTableViewController: UITableViewController {
    var modal = FriendListModel();
    let dataArray = NSMutableArray();
    var headerHight = CGFloat();
    var cellHeight = CGFloat();
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell");
        self.getData();
        self.tableView = UITableView.init(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Grouped)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count;
    }
    func CreateView(indexPath:NSIndexPath) -> UIView {
        let models : CommunityCommentModel = dataArray[indexPath.row] as! CommunityCommentModel;
        let view = UIView();
        let icon = UIImageView();
        let name = UILabel();
        let time = UILabel();
        let content = UILabel()
        view.addSubview(icon);
        view.addSubview(name);
        view.addSubview(time);
        view.addSubview(content);
        
        view.frame = CGRectMake(0, 0,UIScreen.mainScreen().bounds.size.width, 100);
        icon.frame = CGRectMake(20, 20, 35, 35);
        icon.sd_setImageWithURL(NSURL.init(string: models.user_avatar))
        name.text = models.nickname;
        let maxSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 999);
        let expectSize = name.sizeThatFits(maxSize);
        name.frame = CGRectMake(CGRectGetMaxX(icon.frame), icon.frame.origin.y, expectSize.width, expectSize.height);
        time.text = models.created;
        let maxSize2 = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 999);
        let expectSize2 = time.sizeThatFits(maxSize2);
        time.frame = CGRectMake(name.frame.origin.x, CGRectGetMaxY(name.frame), expectSize2.width, expectSize2.height);
        content.text = models.content;
        let maxSize3 = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 999);
        let expectSize3 = content.sizeThatFits(maxSize3);
        content.frame = CGRectMake(time.frame.origin.x, CGRectGetMaxY(time.frame) + 20, expectSize3.width, expectSize3.height);
        cellHeight = CGRectGetMaxY(content.frame) + 20;
        return view
        
        
        
        
    }
    func getData() -> Void {
        var url = NSURL();
        url = NSURL.init(string: "http://lol.zhangyoubao.com/apis/rest/UgcsService/companionComments?id=\(modal.id)&page=1&userid=25265305&i_=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&deviceId=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&t_=1471573944287&p_=15206&v_=400901&a_=lol&pkg_=com.anzogame.lol&d_=android&osv_=23&cha=xiaomiMartket&u_=25265305&modle_=MI%20NOTE%20LTE&api=UgcsService.companionComments&time=1471573944&game=lol&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&secretVersion=v1.0&nonce=848890&secretSignature=C4YTcj8neuSN6OfXAcDVpphMO+8=")!;
        let session = NSURLSession.sharedSession();
        let task = session.dataTaskWithURL(url) { (data, response, error) in
            var dict = NSMutableDictionary();
            dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSMutableDictionary
            let array : NSArray = dict["data"] as! NSArray;
            
            for item in array {
                let model = CommunityCommentModel()
                
                model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                
                self.dataArray.addObject(model);
                
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData();
            })
        }
        task.resume();

        
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let icon = UIImageView();
        let name = UILabel();
        let sex = UIImageView();
        let summnor = UILabel();
        let Zdl = UILabel();
        let devide = UIImageView();
//        let time = UILabel();
        let position = UILabel()
        let voice = UILabel();
        let goodAt = UILabel();
        let city = UILabel();
        let slogan = UILabel();
        view.frame = CGRectMake(10, 10, UIScreen.mainScreen().bounds.size.width - 20, UIScreen.mainScreen().bounds.height - 20);
        icon.frame = CGRectMake(10, 10, 35, 35);
        icon.sd_setImageWithURL(NSURL.init(string: modal.avatar));
        name.text = modal.nickname;
        let maxSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 999);
        let expectSize = name.sizeThatFits(maxSize);
        name.frame = CGRectMake(CGRectGetMaxX(icon.frame) + 10, icon.frame.origin.y, expectSize.width, expectSize.height);
        sex.frame = CGRectMake(CGRectGetMaxX(name.frame) + 5, name.frame.origin.y, 20, 20)
        if modal.sex == "1" {
            sex.image = UIImage.init(named: "男")
        }else
        {
            sex.image = UIImage.init(named: "女");
        }
        summnor.text = modal.summoner;
        let maxSize2 = CGSizeMake(UIScreen.mainScreen().bounds.width, 999);
        let expectSize2 = summnor.sizeThatFits(maxSize2)
        summnor.frame = CGRectMake(name.frame.origin.x,CGRectGetMaxY(name.frame), expectSize2.width, expectSize2.height);
        Zdl.text = "战斗力:\(modal.zdl)";
        let maxSize3 = CGSizeMake(UIScreen.mainScreen().bounds.width, 999);
        let expectSize3 = Zdl.sizeThatFits(maxSize3)
        Zdl.frame = CGRectMake(summnor.frame.origin.x, CGRectGetMaxY(summnor.frame), expectSize3.width, expectSize3.height);
        
        devide.frame = CGRectMake(0, CGRectGetMaxY(Zdl.frame) + 15, view.frame.size.width, 1);
        devide.backgroundColor = UIColor.lightGrayColor();
        position.text = "擅长位置:\(modal.field)";
        let maxSize4 = CGSizeMake(UIScreen.mainScreen().bounds.width, 999);

        let expectSize4 = position.sizeThatFits(maxSize4)
        position.frame = CGRectMake(icon.frame.origin.x, CGRectGetMaxY(devide.frame) + 20,expectSize4.width, expectSize4.height);
        if modal.enable_voice == "0" {
            voice.text = "开黑语音:不确定"
        }else if modal.enable_voice == "1"
        {
            voice.text = "开黑语音:不愿意"
        }else
        {
            voice.text = "开黑语音:好啊好啊"
        }
        let maxSize5 = CGSizeMake(UIScreen.mainScreen().bounds.width, 999);

        let expectSize5 = voice.sizeThatFits(maxSize5)
        voice.frame = CGRectMake(position.frame.origin.x , CGRectGetMaxY(position.frame), expectSize5.width, expectSize5.height);
        goodAt.text = "擅长英雄:\(modal.good_at)";
        let maxSize6 = CGSizeMake(UIScreen.mainScreen().bounds.width, 999);

        let expectSize6 = goodAt.sizeThatFits(maxSize6)
        goodAt.frame = CGRectMake(voice.frame.origin.x, CGRectGetMaxY(voice.frame), expectSize6.width, expectSize6.height);
        if modal.city == "" {
            city.text = "所在城市:未知"
        }else
        {
            city.text = "所在城市:\(modal.city)";
        }
        let maxSize7 = CGSizeMake(UIScreen.mainScreen().bounds.width, 999);

        let expectSize7 = city.sizeThatFits(maxSize7)
        city.frame = CGRectMake(goodAt.frame.origin.x, CGRectGetMaxY(goodAt.frame), expectSize7.width, expectSize7.height);
        slogan.text = "约战宣言:\(modal.slogan)";
        let maxSize8 = CGSizeMake(UIScreen.mainScreen().bounds.width, 999);

        let expectSize8 = slogan.sizeThatFits(maxSize8)
        slogan.frame = CGRectMake(city.frame.origin.x, CGRectGetMaxY(city.frame), expectSize8.width, expectSize8.height);
        view.addSubview(icon);
        view.addSubview(name);
        view.addSubview(sex);
        view.addSubview(summnor);
        view.addSubview(Zdl);
        view.addSubview(devide);
        view.addSubview(position);
        view.addSubview(voice);
        view.addSubview(goodAt);
        view.addSubview(city);
        view.addSubview(slogan);
        headerHight = CGRectGetMaxY(slogan.frame) + 20;
        print(headerHight)
        
        
        
        return view;
        
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHight;
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            var view = UIView();
            view = self.CreateView(indexPath);
            cell!.contentView.addSubview(view)
//            self.tableView(tableView, viewForHeaderInSection: indexPath.section);
        }
        
        return cell!
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

}
