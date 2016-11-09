//
//  HerosViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/11.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class HerosViewController: UIViewController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {

    
    var segmentItem : UISegmentedControl = UISegmentedControl();
    let items = ["搜索","英雄列表"];
    var heroSelect : DBSphereView = DBSphereView()
    var heroList : UITableView = UITableView()
    var heroScroll : UIScrollView = UIScrollView()
    lazy var allHeroArray : [AllHeroModel!] = [AllHeroModel]()
    lazy var heroTitleArray : NSMutableArray = NSMutableArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "英雄"
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "个人"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HerosViewController.personButtonAction(_:)));
        
        self.buju()
        self.getChildView()
        self.getData()
        // Do any additional setup after loading the view.
    }
    
    func personButtonAction(sender:UIBarButtonItem) -> Void {
        NSNotificationCenter.defaultCenter().postNotificationName("showleft", object: nil);
    }
    func buju(){
        let width = self.view.frame.size.width
        let height : CGFloat = 40
        self.segmentItem = UISegmentedControl.init(items: items);
        self.segmentItem.backgroundColor = UIColor.whiteColor()
        self.segmentItem.addTarget(self, action: #selector(HerosViewController.segmentAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.segmentItem.frame = CGRectMake(0, 0, width, height);
        self.segmentItem.tintColor = UIColor(red: 43.0/255.0, green: 46.0/255.0, blue: 53.0/255.0, alpha: 1)
        self.segmentItem.selectedSegmentIndex = 0;
        self.view.addSubview(self.segmentItem)
        let  heights : CGFloat = self.view.frame.height
        heroScroll.frame = CGRectMake(0, 40, width, heights);
        self.heroScroll.contentSize = CGSizeMake(width*2, heights);
        self.heroScroll.pagingEnabled = true;
        self.heroScroll.delegate = self;
        self.heroScroll.alwaysBounceHorizontal = true;
        self.view.addSubview(self.heroScroll)

    }
    func getChildView(){
        
        let width = self.view.frame.size.width;
        let height = self.view.frame.size.height;
        self.heroSelect.frame = CGRectMake(0,100,width,height)
        self.heroSelect.backgroundColor = UIColor.clearColor()

        self.heroScroll.addSubview(self.heroSelect)
        self.heroList = UITableView.init(frame: CGRectMake(width,-35, width, height), style: UITableViewStyle.Grouped)
        self.heroList.delegate = self
        self.heroList.dataSource = self
        self.heroList.registerClass(HeroClassesTableViewCell.self, forCellReuseIdentifier: "HeroClassesTableViewCell")
        self.heroScroll.addSubview(self.heroList)
        self.heroList.backgroundColor = UIColor.whiteColor()
    }

    func segmentAction(sender:UISegmentedControl){
        let width = CGFloat(sender.selectedSegmentIndex) * self.view.frame.size.width
        
        self.heroScroll.setContentOffset(CGPointMake(width, 0), animated: true);
    }
    internal func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let segementNum = self.heroScroll.contentOffset.x / self.view.frame.size.width
        self.segmentItem.selectedSegmentIndex = NSInteger(segementNum);
        
    }
    func addHero(){
        let array : NSMutableArray = NSMutableArray()
        for i in 0..<self.allHeroArray.count {
                        let heroBtn = UIButton.init(type: UIButtonType.System)
            heroBtn.setTitle(self.heroTitleArray[i] as? String, forState: UIControlState.Normal)
            heroBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
            heroBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            heroBtn.tag = i;
            heroBtn.frame = CGRectMake(0, 0, 80, 20)
            heroBtn.sizeToFit()
            heroBtn.addTarget(self, action: #selector(HerosViewController.pushAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            [array.addObject(heroBtn)];
            self.heroSelect.addSubview(heroBtn)
        }
        self.heroSelect.setCloudTags(array as [AnyObject])
        
    }
    
    func getData(){
        let url = NSURL.init(string: allHeroUrl)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if data != nil {
                
                let dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let array = dic["all"] as! NSArray;
                for item in array {
                    
                let model : AllHeroModel = AllHeroModel();
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject]);
                self.allHeroArray.append(model);
                self.heroTitleArray.addObject(model.title);
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    self.addHero()
                })
                
                
            }
        }
        task.resume()
    }
    
    func pushAction(sender:UIButton){
        let heroDetail = HeroDetailViewController()
        heroDetail.model = self.allHeroArray[sender.tag]
        heroDetail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(heroDetail, animated: true)
        
    }
    
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HeroClassesTableViewCell"  , forIndexPath: indexPath) as! HeroClassesTableViewCell
        if indexPath.row == 0{
            cell.textImageView.image = UIImage.init(named: "heroFont")
            cell.tupianImageView.image = UIImage.init(named: "heros")
 
        }else if indexPath.row == 1 {
            cell.textImageView.image = UIImage.init(named: "equipFont")
            cell.tupianImageView.image = UIImage.init(named: "equips")
            
        }else{
            cell.textImageView.image = UIImage.init(named: "runesFont")
            cell.tupianImageView.image = UIImage.init(named: "runes")
        }
        return cell
        
        
    }
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1;
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (self.view.frame.height-40-44)/3
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0{
            let hero : HerosHerosViewController = HerosHerosViewController()
            hero.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(hero, animated: true)
            
        }else if indexPath.row == 1 {
            let equips : HerosEquipsViewController = HerosEquipsViewController()
            equips.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(equips, animated: true)
            
        }else{
            let runes : HerosRunesViewController = HerosRunesViewController()
            runes.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(runes, animated: true)
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    
    
    

}
