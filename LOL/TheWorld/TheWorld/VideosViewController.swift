//
//  VideosViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/11.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class VideosViewController: UIViewController,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    
    var segmentItem : UISegmentedControl = UISegmentedControl();
    let items = ["娱乐","解说","赛事"];
    var scroll : UIScrollView = UIScrollView();
    var playCollection = UICollectionView?();
    var talkCollection = UICollectionView?();
    var sportCollection = UICollectionView?();
    var playLayout = UICollectionViewFlowLayout()
    var talkLayout = UICollectionViewFlowLayout()
    var sportLayout = UICollectionViewFlowLayout()

    lazy var videoPlayArray : [VideoListModel]! = [VideoListModel]();
    lazy var videoTalkArray : [VideoListModel]! = [VideoListModel]();
    lazy var videoSportArray : [VideoListModel]! = [VideoListModel]();
    override func viewDidAppear(animated: Bool) {
        if NightModeManager.Singleton.sharedInstance.isNight == true {
            self.scroll.backgroundColor = UIColor.blackColor();
            let segementNum = NSInteger(self.scroll.contentOffset.x / self.view.frame.size.width)
            switch segementNum {
            case 0:
                dispatch_async(dispatch_get_main_queue(), { 
                    self.playCollection?.reloadData();

                })
                break;
            case 1:
                dispatch_async(dispatch_get_main_queue(), { 
                    self.talkCollection?.reloadData();

                })
                break;
           
            default:
                dispatch_async(dispatch_get_main_queue(), { 
                    self.sportCollection?.reloadData();

                })
                break;

            }
            
            
        }else
        {
            let segementNum = NSInteger(self.scroll.contentOffset.x / self.view.frame.size.width)
            switch segementNum {
            case 0:
                dispatch_async(dispatch_get_main_queue(), {
                    self.playCollection?.reloadData();
                    
                })
                break;
            case 1:
                dispatch_async(dispatch_get_main_queue(), {
                    self.talkCollection?.reloadData();
                    
                })
                break;
                
            default:
                dispatch_async(dispatch_get_main_queue(), {
                    self.sportCollection?.reloadData();
                    
                })
                break;
                
            }
            self.scroll.backgroundColor = UIColor.whiteColor();
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "视频";
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "个人"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(VideosViewController.personButtonAction(_:)));
        

        self.buju();
        self.creatTableView();
        self.getDelegate()
        self.getData()
        playCollection?.backgroundColor = UIColor.clearColor();
        talkCollection?.backgroundColor = UIColor.clearColor();
        sportCollection?.backgroundColor = UIColor.clearColor();
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VideosViewController.viewDidAppear(_:)), name: "reload", object: nil);
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
        self.segmentItem.addTarget(self, action: #selector(InformationsViewController.segmentAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.segmentItem.frame = CGRectMake(0, 0, width, height);
        self.segmentItem.tintColor = UIColor(red: 43.0/255.0, green: 46.0/255.0, blue: 53.0/255.0, alpha: 1)
        self.segmentItem.selectedSegmentIndex = 0;
        self.view.addSubview(self.segmentItem);
        let heights = self.view.frame.size.height-height
        self.scroll.frame = CGRectMake(0, 40, width, heights);
        self.scroll.contentSize = CGSizeMake(width*3, heights);
        self.scroll.pagingEnabled = true;
        self.scroll.delegate = self;
        self.scroll.alwaysBounceHorizontal = true;
        self.view.addSubview(self.scroll)
        self.playLayout.itemSize = CGSizeMake((self.view.frame.size.width-40)/3.0, (self.view.frame.size.width-40)/3.0+40);
        self.playLayout.minimumLineSpacing = 10.0;
        self.playLayout.minimumInteritemSpacing = 10.0;
        self.playLayout.scrollDirection = UICollectionViewScrollDirection.Vertical;
        self.talkLayout.itemSize = CGSizeMake((self.view.frame.size.width-40)/3.0, (self.view.frame.size.width-40)/3.0+40);
        self.talkLayout.minimumLineSpacing = 10.0;
        self.talkLayout.minimumInteritemSpacing = 10.0;
        self.talkLayout.scrollDirection = UICollectionViewScrollDirection.Vertical;
        self.sportLayout.itemSize = CGSizeMake((self.view.frame.size.width-40)/3.0, (self.view.frame.size.width-40)/3.0+40);
        self.sportLayout.minimumLineSpacing = 10.0;
        self.sportLayout.minimumInteritemSpacing = 10.0;
        self.sportLayout.scrollDirection = UICollectionViewScrollDirection.Vertical;
    }
    
    func creatTableView(){
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height-65-40-49
        self.playCollection = UICollectionView(frame: CGRectMake(0, 0, width, height), collectionViewLayout: self.playLayout);
        self.scroll.addSubview(self.playCollection!);
        self.talkCollection = UICollectionView(frame: CGRectMake(width, 0, width, height), collectionViewLayout: self.talkLayout);
        self.scroll.addSubview(self.talkCollection!);
        self.sportCollection = UICollectionView(frame: CGRectMake(width*2, 0, width, height), collectionViewLayout: self.sportLayout);
        self.scroll.addSubview(self.sportCollection!);

        self.playCollection?.backgroundColor = UIColor.whiteColor();
        self.talkCollection?.backgroundColor = UIColor.whiteColor();
        self.sportCollection?.backgroundColor = UIColor.whiteColor();
        
    }

    
    
    func getDelegate(){
        
        
        let segementNum = NSInteger(self.scroll.contentOffset.x / self.view.frame.size.width)
        switch segementNum {
        case 0:
            self.playCollection?.delegate = self;
            self.playCollection?.dataSource = self;
            self.playCollection?.registerClass(PlayCollectionViewCell.self, forCellWithReuseIdentifier: "PlayCollectionViewCell");
            dispatch_async(dispatch_get_main_queue(), { 
                self.playCollection?.reloadData();
            })
        case 1:
            self.talkCollection?.delegate = self;
            self.talkCollection?.dataSource = self;
            self.talkCollection?.registerClass(TalkCollectionViewCell.self, forCellWithReuseIdentifier: "TalkCollectionViewCell")
            dispatch_async(dispatch_get_main_queue(), {
                self.talkCollection?.reloadData();
            })
        case 2:
            self.sportCollection?.delegate = self;
            self.sportCollection?.dataSource = self;
            self.sportCollection?.registerClass(SportCollectionViewCell.self, forCellWithReuseIdentifier: "SportCollectionViewCell")
            dispatch_async(dispatch_get_main_queue(), {
                self.sportCollection?.reloadData();
            })
        default:
            print("出错了");
        }
        
        
        
    }
    func getData(){
        self.getPlayData();
        self.getTalkData();
        self.getSportData();
    }
    func getPlayData(){
        let url : NSURL = NSURL.init(string: videoItemUrl)!;
        let  session = NSURLSession.sharedSession();
        let task = session.dataTaskWithURL(url) { (data, response, error) in
            
            if data != nil {
                let dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let array : NSMutableArray = dic["data"]![0]!["catword_id"] as! NSMutableArray;
                
                for item in array {
                    let model = VideoListModel()
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                    self.videoPlayArray.append(model)
                }
            }
            dispatch_async(dispatch_get_main_queue(), { 
                self.playCollection?.reloadData();
            })
            
        }
        task.resume()
        
    }
    func getTalkData(){
        let url : NSURL = NSURL.init(string: videoItemUrl)!;
        let  session = NSURLSession.sharedSession();
        let task = session.dataTaskWithURL(url) { (data, response, error) in
            
            if data != nil {
                let dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let array : NSMutableArray = dic["data"]![1]!["catword_id"] as! NSMutableArray;
                
                for item in array {
                    let model = VideoListModel()
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                    self.videoTalkArray.append(model)
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.talkCollection?.reloadData();
            })

        }
        task.resume()
        
    }
    func getSportData(){
        let url : NSURL = NSURL.init(string: videoItemUrl)!;
        let  session = NSURLSession.sharedSession();
        let task = session.dataTaskWithURL(url) { (data, response, error) in
            
            if data != nil {
                let dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let array : NSMutableArray = dic["data"]![2]!["catword_id"] as! NSMutableArray;
                
                for item in array {
                    let model = VideoListModel()
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                    self.videoSportArray.append(model)
                }
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.sportCollection?.reloadData();
            })

            
        }
        task.resume()
        
    }

    
    
    
    func segmentAction(sender:UISegmentedControl){
        let width = CGFloat(sender.selectedSegmentIndex) * self.view.frame.size.width
        self.scroll.setContentOffset(CGPointMake(width, 0), animated: true);
    }
    
    
    internal func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let segementNum = self.scroll.contentOffset.x / self.view.frame.size.width
        self.segmentItem.selectedSegmentIndex = NSInteger(segementNum);
        self.getDelegate();
        
    }
    internal func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.getDelegate();
    }

    
    
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        let segementNum = NSInteger(self.scroll.contentOffset.x / self.view.frame.size.width)
        if segementNum == 0 {
            return self.videoPlayArray.count;
        }else if segementNum == 1{
            return self.videoTalkArray.count;
            
        }
        return self.videoSportArray.count;
    }
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let segementNum = NSInteger(self.scroll.contentOffset.x / self.view.frame.size.width)
        if segementNum == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PlayCollectionViewCell", forIndexPath: indexPath) as! PlayCollectionViewCell
            var model = VideoListModel();
            model = self.videoPlayArray[indexPath.row];
            cell.model = model;
            cell.backgroundColor = UIColor.clearColor();
            return cell
        }else if(segementNum == 1){
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TalkCollectionViewCell", forIndexPath: indexPath) as! TalkCollectionViewCell
            var model = VideoListModel();
            model = self.videoTalkArray[indexPath.row];
            cell.model = model;
            cell.backgroundColor = UIColor.clearColor();
            return cell
        }
    
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SportCollectionViewCell", forIndexPath: indexPath) as! SportCollectionViewCell
        var model = VideoListModel();
        model = self.videoSportArray[indexPath.row];
        cell.backgroundColor = UIColor.clearColor();
        cell.model = model;
        return cell;
        
        
    }
    internal func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        
        return 1;
        
    }
    internal func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let segementNum = NSInteger(self.scroll.contentOffset.x / self.view.frame.size.width)

        if segementNum == 0{
            let list = VideoListViewController();
            var model = VideoListModel()
            model = self.videoPlayArray[indexPath.row];
            list.selfTitle = model.name;
            list.id = model.id;
            list.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(list, animated: true)
        }else if segementNum == 1{
            
            let talk = VideoTalkViewController();
            var model = VideoListModel()
            model = self.videoTalkArray[indexPath.row];
            talk.id = model.id;
            talk.selfTitle = model.name;
            talk.hidesBottomBarWhenPushed = true;

            self.navigationController?.pushViewController(talk, animated: true)
        }else{
            let sport = VideoSportViewController();
            var model = VideoListModel()
            model = self.videoSportArray[indexPath.row];
            sport.selfTitle = model.name;
            sport.id = model.id;
            sport.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(sport, animated: true)
        }
        
        
        
        
        
        
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
