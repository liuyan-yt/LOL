//
//  HerosRunesViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/19.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class HerosRunesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var segmentItem : UISegmentedControl = UISegmentedControl();
    let items = ["印记(红)","雕纹(蓝)","符文(黄)","精华"];
    let runes : UIScrollView = UIScrollView()
    var red : UITableView = UITableView()
    var blue : UITableView = UITableView()
    var yellow : UITableView = UITableView()
    var purple : UITableView = UITableView()
    lazy var redArray : [HeroRunesModel!] = [HeroRunesModel]()
    lazy var blueArray : [HeroRunesModel!] = [HeroRunesModel]()
    lazy var yellowArray : [HeroRunesModel!] = [HeroRunesModel]()
    lazy var purpleArray : [HeroRunesModel!] = [HeroRunesModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "符文"
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "返回"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HerosRunesViewController.leftAction));

        self.buju()
        self.getTableView()
        self.getDelegate()
        self.getData()
    }
    func leftAction(){
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    func buju(){
        let width = self.view.frame.size.width
        let height : CGFloat = 40
        self.segmentItem = UISegmentedControl.init(items: items);
        self.segmentItem.backgroundColor = UIColor.whiteColor()
        self.segmentItem.addTarget(self, action: #selector(HerosRunesViewController.segmentAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.segmentItem.frame = CGRectMake(0, 0, width, height);
        self.segmentItem.tintColor = UIColor(red: 23.0/255.0, green: 36.0/255.0, blue: 43.0/255.0, alpha: 1)
        self.segmentItem.selectedSegmentIndex = 0;
        self.view.addSubview(self.segmentItem)
        let  heights : CGFloat = self.view.frame.height
        self.runes.frame = CGRectMake(0, 40, width, heights);
        self.runes.contentSize = CGSizeMake(width*4, heights);
        self.runes.pagingEnabled = true;
        self.runes.delegate = self;
        self.runes.alwaysBounceHorizontal = true;
        self.view.addSubview(self.runes)
        
    }
    func getTableView(){
        
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height-29
        self.red = UITableView(frame: CGRectMake(0, -35, width, height), style: UITableViewStyle.Grouped)
        
        self.runes.addSubview(self.red);
        self.blue = UITableView(frame: CGRectMake(width,-35, width, height), style: UITableViewStyle.Grouped)
        self.runes.addSubview(self.blue);
        self.yellow = UITableView(frame: CGRectMake(width*2, -35, width, height), style: UITableViewStyle.Grouped)
        self.runes.addSubview(self.yellow);
        self.purple = UITableView(frame: CGRectMake(width*3, -35, width, height), style: UITableViewStyle.Grouped)
        self.runes.addSubview(self.purple);
    }
    func getDelegate(){
        let segementNum = NSInteger(self.runes.contentOffset.x / self.view.frame.size.width)
        switch segementNum {
        case 0:
            self.red.delegate = self
            self.red.dataSource = self
            self.red.registerClass(HeroRunesTableViewCell.self, forCellReuseIdentifier: "HeroRunesTableViewCell")
            dispatch_async(dispatch_get_main_queue()) {
                self.red.reloadData()
            }
            break
        case 1:
            self.blue.delegate = self
            self.blue.dataSource = self
            self.blue.registerClass(HeroRunesTableViewCell.self, forCellReuseIdentifier: "HeroRunesTableViewCell")
            dispatch_async(dispatch_get_main_queue()) {
                self.blue.reloadData()
            }
            break
        case 2:
            self.yellow.delegate = self
            self.yellow.dataSource = self
            self.yellow.registerClass(HeroRunesTableViewCell.self, forCellReuseIdentifier: "HeroRunesTableViewCell")
            dispatch_async(dispatch_get_main_queue()) {
                self.yellow.reloadData()
            }
            
            break
        case 3:
            self.purple.delegate = self
            self.purple.dataSource = self
            self.purple.registerClass(HeroRunesTableViewCell.self, forCellReuseIdentifier: "HeroRunesTableViewCell")
            dispatch_async(dispatch_get_main_queue()) {
                self.purple.reloadData()
            }
            break
        default:
            print("dsdsds");
        }
    }
    func getData(){
        self.getRedData()
        self.getBlueData()
        self.getYellowData()
        self.getPurpleData()
    }
    func getRedData(){
        let url = NSURL.init(string: runesUrl)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            
            let dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            let array = dic["Red"] as! NSArray
            for item in array{
                let model = HeroRunesModel()
                model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                self.redArray.append(model);
            }
            dispatch_async(dispatch_get_main_queue(), { 
                self.red.reloadData()
            })
        }
        
        task.resume()
        
    }
    func getBlueData(){
        let url = NSURL.init(string: runesUrl)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            
            let dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            let array = dic["Blue"] as! NSArray
            for item in array{
                let model = HeroRunesModel()
                model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                self.blueArray.append(model);
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.blue.reloadData()
            })
        }
        
        task.resume()
        
        
        
    }
    func getYellowData(){
        let url = NSURL.init(string: runesUrl)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            
            let dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            let array = dic["Yellow"] as! NSArray
            for item in array{
                let model = HeroRunesModel()
                model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                self.yellowArray.append(model);
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.yellow.reloadData()
            })
        }
        
        task.resume()
        
        
        
    }
    func getPurpleData(){
        let url = NSURL.init(string: runesUrl)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            
            let dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            let array = dic["Purple"] as! NSArray
            for item in array{
                let model = HeroRunesModel()
                model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                self.purpleArray.append(model);
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.purple.reloadData()
            })
        }
        
        task.resume()
        
        
        
    }
    func segmentAction(sender:UISegmentedControl){
        let width = CGFloat(sender.selectedSegmentIndex) * self.view.frame.size.width
        self.runes.setContentOffset(CGPointMake(width, 0), animated: true);
    }
    
    internal func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let segementNum = self.runes.contentOffset.x / self.view.frame.size.width
        self.segmentItem.selectedSegmentIndex = NSInteger(segementNum);
        self.getDelegate()
    }
    internal func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.getDelegate()
    }
   
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let segementNum = NSInteger(self.runes.contentOffset.x / self.view.frame.size.width)
        if segementNum == 0 {
            return self.redArray.count
        }else if segementNum == 1{
            return self.blueArray.count
        }else if segementNum == 2{
            return self.yellowArray.count
        }
        return self.purpleArray.count
    }
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HeroRunesTableViewCell", forIndexPath: indexPath) as! HeroRunesTableViewCell
        let segementNum = NSInteger(self.runes.contentOffset.x / self.view.frame.size.width)
        switch segementNum {
        case 0:
            let model = self.redArray[indexPath.row]
            cell.model = model;
            break
        case 1:
            let model = self.blueArray[indexPath.row]
            cell.model = model;
            break
        case 2:
            let model = self.yellowArray[indexPath.row]
            cell.model = model;
            break
        case 3:
            let model = self.purpleArray[indexPath.row]
            cell.model = model;
            break
        default:
            print("dsdsds");
        }
        return cell
    }
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1;
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

}
