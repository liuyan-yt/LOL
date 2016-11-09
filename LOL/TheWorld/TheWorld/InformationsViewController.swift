
//
//  InformationsViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/11.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class InformationsViewController: UIViewController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate {

    var segment : UISegmentedControl = UISegmentedControl();
    let scroll : UIScrollView = UIScrollView();
    var lastTableView : UITableView = UITableView();
    var newsTableView : UITableView =  UITableView();
    var sportTableView : UITableView = UITableView();
    var playTableView : UITableView = UITableView();
    lazy var lastListArray : [LastListModel]! = [LastListModel]()
    lazy var newsListArray : [LastListModel]! = [LastListModel]()
    lazy var sportListArray : [LastListModel]! = [LastListModel]()
    lazy var playListArray : [LastListModel]! = [LastListModel]()
    let items = ["最新","新闻","赛事","娱乐"];
    var last = 1
    var news = 1
    var sport = 1
    var play = 1
    var headView = HeadScrollView();
    override func viewDidAppear(animated: Bool) {
        if NightModeManager.Singleton.sharedInstance.isNight == true {
            self.scroll.backgroundColor = UIColor.blackColor();
            let segementNum = NSInteger(self.scroll.contentOffset.x / self.view.frame.size.width)
            switch segementNum {
            case 0:
                lastTableView.reloadData();
                break;
            case 1:
                newsTableView.reloadData();
                break;
            case 2:
                sportTableView.reloadData()
                break;
            default:
                playTableView.reloadData();
                break;
            }
        }else
        {
            self.scroll.backgroundColor = UIColor.whiteColor();
            let segementNum = NSInteger(self.scroll.contentOffset.x / self.view.frame.size.width)
            switch segementNum {
            case 0:
                lastTableView.reloadData();
                break;
            case 1:
                newsTableView.reloadData();
                break;
            case 2:
                sportTableView.reloadData()
                break;
            default:
                playTableView.reloadData();
                break;
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新闻资讯"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "个人"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InformationsViewController.personButtonAction(_:)));
        self.view.backgroundColor = UIColor.whiteColor()
        self.bujuAction()
        self.creatTableView()
        self.getDelegate()
        self.getData()
        lastTableView.backgroundColor = UIColor.clearColor();
        newsTableView.backgroundColor = UIColor.clearColor();
        sportTableView.backgroundColor = UIColor.clearColor();
        playTableView.backgroundColor = UIColor.clearColor();
        self.scroll.bounces = false;
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InformationsViewController.reload), name: "reload", object: nil);
        }
    

    
    func personButtonAction(sender:UIBarButtonItem) -> Void {
        NSNotificationCenter.defaultCenter().postNotificationName("showleft", object: nil);
    }
    func reload() -> Void {
        self.viewDidAppear(true);
    }
    func bujuAction(){
        self.segment = UISegmentedControl.init(items: items);
        self.segment.backgroundColor = UIColor.whiteColor()
        self.segment.addTarget(self, action: #selector(InformationsViewController.segmentAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.segment.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
        self.segment.tintColor = UIColor(red: 43.0/255.0, green: 46.0/255.0, blue: 53.0/255.0, alpha: 1)
        self.segment.selectedSegmentIndex = 0;
        self.view.addSubview(self.segment);
        
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height-40-65-49
        self.scroll.frame = CGRectMake(0, 40, width, height);
        self.scroll.contentSize = CGSizeMake(width*4, height);
        self.scroll.pagingEnabled = true;
        self.scroll.delegate = self;
        self.scroll.alwaysBounceHorizontal = true;
        self.view.addSubview(self.scroll)
    }
    func creatTableView(){
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height-65-49
        self.lastTableView = UITableView(frame: CGRectMake(0, 0, width, height), style: UITableViewStyle.Grouped)

        self.scroll.addSubview(self.lastTableView);
        self.newsTableView = UITableView(frame: CGRectMake(width,-40, width, height), style: UITableViewStyle.Grouped)
        self.scroll.addSubview(self.newsTableView);
        self.sportTableView = UITableView(frame: CGRectMake(width*2, -40, width, height), style: UITableViewStyle.Grouped)
        self.scroll.addSubview(self.sportTableView);
        self.playTableView = UITableView(frame: CGRectMake(width*3, -40, width, height), style: UITableViewStyle.Grouped)
        self.scroll.addSubview(self.playTableView);
        
    }
    func getDelegate(){
        let segementNum = NSInteger(self.scroll.contentOffset.x / self.view.frame.size.width)
        switch segementNum {
        case 0:
            self.lastTableView.delegate = self
            self.lastTableView.dataSource = self
            self.lastTableView.registerClass(LastTableViewCell.self, forCellReuseIdentifier: "LastTableViewCell")
            dispatch_async(dispatch_get_main_queue()) {
                self.lastTableView.reloadData()
            }
            break
        case 1:
            self.newsTableView.delegate = self
            self.newsTableView.dataSource = self
            self.newsTableView.registerClass(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
            dispatch_async(dispatch_get_main_queue()) {
                self.newsTableView.reloadData()
            }
            break
        case 2:
            self.sportTableView.delegate = self
            self.sportTableView.dataSource = self
            self.sportTableView.registerClass(SportTableViewCell.self, forCellReuseIdentifier: "SportTableViewCell")
            dispatch_async(dispatch_get_main_queue()) {
                self.sportTableView.reloadData()
            }
            
            break
        case 3:
            self.playTableView.delegate = self
            self.playTableView.dataSource = self
            self.playTableView.registerClass(PlayTableViewCell.self, forCellReuseIdentifier: "PlayTableViewCell")
            dispatch_async(dispatch_get_main_queue()) {
                self.playTableView.reloadData()
            }
            break
        default:
            print("dsdsds")
        }
        
    }
    func getData(){
        self.getLastListData(1)
        self.getNewsListData(1)
        self.getSportListData(1)
        self.getPlayListData(1)
        
    }
    func getLastListData(page:Int){
        
        let url = NSURL.init(string: informationLastListUrl1+String(page)+informationLastListUrl2)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if (data != nil){
                let dic :NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let array : NSMutableArray = dic["data"] as! NSMutableArray;
                for item in array {
                    let model = LastListModel()
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                    self.lastListArray.append(model)
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.lastTableView.reloadData()
                })
            }
        }
        task.resume()
    }
    func getNewsListData(page:Int){
        
        let url = NSURL.init(string: informationNewsListUrl1+String(page)+informationNewsListUrl2)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if (data != nil){
                let dic :NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let array : NSMutableArray = dic["data"] as! NSMutableArray;
                for item in array {
                    let model = LastListModel()
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                    self.newsListArray.append(model)
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.newsTableView.reloadData()
                })
            }
        }
        task.resume()
    }

    func getSportListData(page:Int){
        
        let url = NSURL.init(string: informationSportListUrl1+String(page)+informationSportListUrl2)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if (data != nil){
                let dic :NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let array : NSMutableArray = dic["data"] as! NSMutableArray;
                for item in array {
                    let model = LastListModel()
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                    self.sportListArray.append(model)
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.sportTableView.reloadData()
                })
            }
        }
        task.resume()
    }
    func getPlayListData(page:Int){
        
        let url = NSURL.init(string: informationPlayListUrl1+String(page)+informationPlayListUrl2)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if (data != nil){
                let dic :NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let array : NSMutableArray = dic["data"] as! NSMutableArray;
                for item in array {
                    let model = LastListModel()
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                    self.playListArray.append(model)
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.playTableView.reloadData()
                })
            }
        }
        task.resume()
    }
    
    
    func segmentAction(sender:UISegmentedControl){
        let width = CGFloat(sender.selectedSegmentIndex) * self.view.frame.size.width
        
        self.scroll.setContentOffset(CGPointMake(width, 0), animated: true);
    }
    internal func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let segementNum = self.scroll.contentOffset.x / self.view.frame.size.width
        self.segment.selectedSegmentIndex = NSInteger(segementNum);
        self.getDelegate()
        
    }
    internal func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.getDelegate()
    }

    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let num = NSInteger(self.scroll.contentOffset.x/self.view.frame.size.width)
        switch num {
        case 0:
            return self.lastListArray.count;
        case 1:
            return self.newsListArray.count;
        case 2:
            return self.sportListArray.count;
        case 3:
            return self.playListArray.count;
        default:
            print("dsdsds");
        }
        return 10
    }
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let segementNum = NSInteger(self.scroll.contentOffset.x / self.view.frame.size.width)
        if segementNum == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("LastTableViewCell", forIndexPath: indexPath) as! LastTableViewCell
            let model : LastListModel = self.lastListArray[indexPath.row]
            cell.backgroundColor = UIColor.clearColor();
            cell.model = model
            cell.title.numberOfLines = 0;
            cell.title.lineBreakMode = NSLineBreakMode.ByTruncatingTail;
            cell.title.font = UIFont.systemFontOfSize(20)
            if model.pic_url.isEmpty {
                let width = self.view.frame.size.width-20
                let maximumLabelSize = CGSizeMake(width, 48.0);
                let expectsize = cell.title.sizeThatFits(maximumLabelSize)
                cell.title.frame = CGRectMake(10, 10, expectsize.width, expectsize.height);
            
            }else{
                let width = self.view.frame.size.width - CGRectGetMaxX(cell.picture.frame)-10-20
                let maximumLabelSize = CGSizeMake(width, 48.0);
                let expectsize = cell.title.sizeThatFits(maximumLabelSize)
                cell.title.frame = CGRectMake(CGRectGetMaxX(cell.picture.frame)+10, 10, expectsize.width, expectsize.height)
            }
            return cell

        }else if(segementNum == 1){
        let cell = tableView.dequeueReusableCellWithIdentifier("NewsTableViewCell", forIndexPath: indexPath) as! NewsTableViewCell
        let model : LastListModel = self.newsListArray[indexPath.row]
            cell.backgroundColor = UIColor.clearColor();
        cell.model = model
        cell.title.numberOfLines = 0;
        cell.title.lineBreakMode = NSLineBreakMode.ByTruncatingTail;
        cell.title.font = UIFont.systemFontOfSize(20)
            if model.pic_url.isEmpty {
                let width = self.view.frame.size.width-20
                let maximumLabelSize = CGSizeMake(width, 48.0);
                let expectsize = cell.title.sizeThatFits(maximumLabelSize)
                cell.title.frame = CGRectMake(10, 10, expectsize.width, expectsize.height);
                
            }else{
                let width = self.view.frame.size.width - CGRectGetMaxX(cell.picture.frame)-10-20
                let maximumLabelSize = CGSizeMake(width, 48.0);
                let expectsize = cell.title.sizeThatFits(maximumLabelSize)
                cell.title.frame = CGRectMake(CGRectGetMaxX(cell.picture.frame)+10, 10, expectsize.width, expectsize.height)
            }
            return cell
        }else if(segementNum == 2){
            let cell = tableView.dequeueReusableCellWithIdentifier("SportTableViewCell", forIndexPath: indexPath) as! SportTableViewCell
            let model : LastListModel = self.sportListArray[indexPath.row]
            cell.backgroundColor = UIColor.clearColor();
            cell.model = model
            cell.title.numberOfLines = 0;
            cell.title.lineBreakMode = NSLineBreakMode.ByTruncatingTail;
            cell.title.font = UIFont.systemFontOfSize(20)
            if model.pic_url.isEmpty {
                let width = self.view.frame.size.width-20
                let maximumLabelSize = CGSizeMake(width, 48.0);
                let expectsize = cell.title.sizeThatFits(maximumLabelSize)
                cell.title.frame = CGRectMake(10, 10, expectsize.width, expectsize.height);
                
            }else{
                let width = self.view.frame.size.width - CGRectGetMaxX(cell.picture.frame)-10-20
                let maximumLabelSize = CGSizeMake(width, 48.0);
                let expectsize = cell.title.sizeThatFits(maximumLabelSize)
                cell.title.frame = CGRectMake(CGRectGetMaxX(cell.picture.frame)+10, 10, expectsize.width, expectsize.height)
            }
            
            return cell

            
        }else if(segementNum == 3){
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayTableViewCell", forIndexPath: indexPath) as! PlayTableViewCell
        let model : LastListModel = self.playListArray[indexPath.row]
        cell.backgroundColor = UIColor.clearColor();
        cell.model = model
        cell.title.numberOfLines = 0;
        cell.title.lineBreakMode = NSLineBreakMode.ByTruncatingTail;
        cell.title.font = UIFont.systemFontOfSize(20)
        if model.pic_url.isEmpty {
            let width = self.view.frame.size.width-20
            let maximumLabelSize = CGSizeMake(width, 48.0);
            let expectsize = cell.title.sizeThatFits(maximumLabelSize)
            cell.title.frame = CGRectMake(10, 10, expectsize.width, expectsize.height);
            
        }else{
            let width = self.view.frame.size.width - CGRectGetMaxX(cell.picture.frame)-10-20
            let maximumLabelSize = CGSizeMake(width, 48.0);
            let expectsize = cell.title.sizeThatFits(maximumLabelSize)
            cell.title.frame = CGRectMake(CGRectGetMaxX(cell.picture.frame)+10, 10, expectsize.width, expectsize.height)
        }
        return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        return cell

        
    }
    
    
    internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let segementNum = NSInteger(self.scroll.contentOffset.x / self.view.frame.size.width)
        switch segementNum {
        case 0:
            let last = InformationWebViewController()
            var model = LastListModel()
            model = self.lastListArray[indexPath.row];
            var str = informationLastDetailUrl1.stringByAppendingString(String(model.id))
            str = str.stringByAppendingString(informationLastDetailUrl2)
            last.url = NSURL.init(string: str)!;
            var str2 = informationLastDetailUrl1.stringByAppendingString(String(model.id))
            str2 = str2.stringByAppendingString(informationLastDetailUrlNight)
            last.urlNight = NSURL.init(string: str2)!;
            last.hidesBottomBarWhenPushed = true;
            last.model = model

           self.navigationController?.pushViewController(last, animated: true)
            break
        case 1:
            let news = InformationWebViewController()
            var model = LastListModel()
            model = self.newsListArray[indexPath.row];
            var str = informationLastDetailUrl1.stringByAppendingString(String(model.id))
            str = str.stringByAppendingString(informationLastDetailUrl2)
            news.url = NSURL.init(string: str)!;
            var str2 = informationLastDetailUrl1.stringByAppendingString(String(model.id))
            str2 = str2.stringByAppendingString(informationLastDetailUrlNight)
            news.urlNight = NSURL.init(string: str2)!;
            news.hidesBottomBarWhenPushed = true;
            news.model = model
            self.navigationController?.pushViewController(news, animated: true)
            break
        case 2:
            let sport = InformationWebViewController()
            var model = LastListModel()
            model = self.sportListArray[indexPath.row];
            var str = informationLastDetailUrl1.stringByAppendingString(String(model.id))
            str = str.stringByAppendingString(informationLastDetailUrl2)
            sport.url = NSURL.init(string: str)!;
            var str2 = informationLastDetailUrl1.stringByAppendingString(String(model.id))
            str2 = str2.stringByAppendingString(informationLastDetailUrlNight)
            sport.urlNight = NSURL.init(string: str2)!;
            sport.hidesBottomBarWhenPushed = true;
            sport.model = model
            self.navigationController?.pushViewController(sport, animated: true)
            break
        case 3:
            let play = InformationWebViewController()
            var model = LastListModel()
            model = self.playListArray[indexPath.row];
            var str = informationLastDetailUrl1.stringByAppendingString(String(model.id))
            str = str.stringByAppendingString(informationLastDetailUrl2)
            play.url = NSURL.init(string: str)!;
            var str2 = informationLastDetailUrl1.stringByAppendingString(String(model.id))
            str2 = str2.stringByAppendingString(informationLastDetailUrlNight)
            play.urlNight = NSURL.init(string: str2)!;
            play.hidesBottomBarWhenPushed = true;
            play.model = model
            self.navigationController?.pushViewController(play, animated: true)
            break
        default:
            print("dsdsds");
        }
    }
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    internal func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(InformationsViewController.tapAction(_:)))
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        self.headView.imageScroll.addGestureRecognizer(tap)
        return self.headView
        
    }
    internal func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180;
    }
    func tapAction(sender:UITapGestureRecognizer){
        let num = self.headView.page.currentPage
        let web :InformationWebViewController = InformationWebViewController()
        if num != 0 {
            var model : ScrImageModel = ScrImageModel()
            model = self.headView.scrImageArray[num]
            let id = model.goto_param["itemid"] as! String
            var str = informationDetailScrollUrl1.stringByAppendingString(id)
            str = str.stringByAppendingString(informationDetailScrollUrl2)
            let url = NSURL(string: str)
            var str2 = informationDetailScrollUrl1.stringByAppendingString(id)
            str2 = str2.stringByAppendingString(informationLastDetailUrlNight);
            let url2 = NSURL(string: str2)
            web.url = url!
            web.urlNight = url2!;
        }else{
//            let url1 = NSURL(string: "https://shop163237318.taobao.com/shop/view_shop.htm")
//            web.url = url1!
//            web.urlNight = url1!
        }
        
        web.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(web, animated: true)
    }

    
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120;
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let segementNum = self.scroll.contentOffset.x / self.view.frame.size.width
        
        switch segementNum {
        case 0:
            var y = CGFloat()
            if self.last == 1 {
                y = 120*10-self.view.frame.height
            }else{
                y = 120*10
            }

            if (scrollView.contentOffset.y < 0) {
                self.getLastListData(1)
            }else if(scrollView.contentOffset.y >= y){
                self.last = self.last + 1
                self.getLastListData(self.last)
            }


        break;

        case 1:
            var y = CGFloat()
            if self.news == 1 {
                y = 120*10-self.view.frame.height
            }else{
                y = 120*10
            }
            if (scrollView.contentOffset.y < 0) {
                self.getNewsListData(1)
            }else if(scrollView.contentOffset.y >= y ){
                self.news = self.news + 1
                self.getNewsListData(self.news)
            }
            break;
        case 2:
            var y = CGFloat()
            if self.sport == 1 {
                y = 120*10-self.view.frame.height
            }else{
                y = 120*10
            }
            if (scrollView.contentOffset.y < 0) {
                self.getSportListData(1)
            }else if(scrollView.contentOffset.y >= y){
                self.sport = self.sport + 1
                self.getSportListData(self.sport)
            }
            break;
        case 3:
            var y = CGFloat()
            if self.play == 1 {
                y = 120*10-self.view.frame.height
            }else{
                y = 120*10
            }
            if (scrollView.contentOffset.y < 0) {
                self.getPlayListData(1)
            }else if(scrollView.contentOffset.y >= y){
                self.play = self.play + 1
                self.getPlayListData(self.play)
            }
            break;
        default:
            break
        }
        
        
    }
    
    
}
