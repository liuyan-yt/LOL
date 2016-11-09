//
//  HerosHerosViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/19.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class HerosHerosViewController: UIViewController,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {

    var segment : UISegmentedControl = UISegmentedControl();
    let items = ["全部英雄","每周免费"];
    let scroll : UIScrollView = UIScrollView();
    var allHeroCollection = UICollectionView?();
    var freeHeroCollection = UICollectionView?();
    var allLayout = UICollectionViewFlowLayout()
    var freeLayout = UICollectionViewFlowLayout()
    lazy var allHeroArray : [AllHeroModel]! = [AllHeroModel]();
    lazy var freeHeroArray : [AllHeroModel]! = [AllHeroModel]();

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "英雄"
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "返回"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HerosHerosViewController.leftAction));
        self.buju()
        self.creatCollection()
        self.getData()
        self.getDelegate()
        
        // Do any additional setup after loading the view.
    }
    func buju(){
        self.segment = UISegmentedControl.init(items: items);
        self.segment.backgroundColor = UIColor.whiteColor()
        self.segment.addTarget(self, action: #selector(HerosHerosViewController.segmentAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.segment.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
        self.segment.tintColor = UIColor(red: 43.0/255.0, green: 46.0/255.0, blue: 53.0/255.0, alpha: 1)
        self.segment.selectedSegmentIndex = 0;
        self.view.addSubview(self.segment);

        let width = self.view.frame.size.width
        let height = self.view.frame.size.height-65-40
        self.scroll.frame = CGRectMake(0, 40, width, height);
        self.scroll.contentSize = CGSizeMake(width*2, height);
        self.scroll.pagingEnabled = true;
        self.scroll.delegate = self;
        self.scroll.alwaysBounceHorizontal = true;
        self.view.addSubview(self.scroll)
        self.allLayout.itemSize = CGSizeMake((self.view.frame.size.width-40)/3.0, (self.view.frame.size.width-40)/3.0+30);
        self.allLayout.minimumLineSpacing = 10.0;
        self.allLayout.minimumInteritemSpacing = 10.0;
        self.allLayout.scrollDirection = UICollectionViewScrollDirection.Vertical;
        self.freeLayout.itemSize = CGSizeMake((self.view.frame.size.width-60)/2.0, 80);
        self.freeLayout.minimumLineSpacing = 10.0;
        self.freeLayout.minimumInteritemSpacing = 10.0;
        self.freeLayout.scrollDirection = UICollectionViewScrollDirection.Vertical;
    }
    func creatCollection(){
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height-65-40
        self.allHeroCollection = UICollectionView(frame: CGRectMake(0, 0, width, height), collectionViewLayout: self.allLayout);
        self.scroll.addSubview(self.allHeroCollection!);
        self.allHeroCollection?.backgroundColor = UIColor.whiteColor()
        self.freeHeroCollection = UICollectionView(frame: CGRectMake(width, 0, width, height), collectionViewLayout: self.freeLayout);
        self.scroll.addSubview(self.freeHeroCollection!);
        self.freeHeroCollection?.backgroundColor = UIColor.whiteColor()
        
    }

    func getData(){
        self.getAllHero()
        self.getFreeHero()
    }
    func getAllHero(){
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
                }
                dispatch_async(dispatch_get_main_queue(), {
                   self.allHeroCollection?.reloadData()
                })
                
                
            }
        }
        task.resume()
    }
    func getFreeHero(){
        let url = NSURL.init(string: freeHeroUrl)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if data != nil {
                
                let dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let array = dic["free"] as! NSArray;
                for item in array {
                    
                    let model : AllHeroModel = AllHeroModel();
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject]);
                    self.freeHeroArray.append(model);
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.freeHeroCollection?.reloadData()
                })
                
                
            }
        }
        task.resume()

    }
    
    
        func getDelegate(){
        let segementNum = NSInteger(self.scroll.contentOffset.x / self.view.frame.size.width)
        switch segementNum {
        case 0:
            self.allHeroCollection?.delegate = self;
            self.allHeroCollection?.dataSource = self;
            self.allHeroCollection?.registerClass(AllHeroCollectionViewCell.self, forCellWithReuseIdentifier: "AllHeroCollectionViewCell");
        case 1:
            self.freeHeroCollection?.delegate = self;
            self.freeHeroCollection?.dataSource = self;
            self.freeHeroCollection?.registerClass(FreeHeroCollectionViewCell.self, forCellWithReuseIdentifier: "FreeHeroCollectionViewCell")
        
        default:
            print("出错了");
        }
        
        
        
    }
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        let segementNum = NSInteger(self.scroll.contentOffset.x / self.view.frame.size.width)
        if segementNum == 0 {
            return self.allHeroArray.count
        }
        return self.freeHeroArray.count
    }
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let segementNum = NSInteger(self.scroll.contentOffset.x / self.view.frame.size.width)
        if segementNum == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AllHeroCollectionViewCell", forIndexPath: indexPath) as! AllHeroCollectionViewCell
            let model = self.allHeroArray[indexPath.row]
            cell.model = model
            return cell
        }
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FreeHeroCollectionViewCell", forIndexPath: indexPath) as! FreeHeroCollectionViewCell
        let model = freeHeroArray[indexPath.row]
        cell.model = model
        return cell
        
    }
    internal func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1

    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let hero = HeroDetailViewController()
        hero.hidesBottomBarWhenPushed = true

        let segementNum = self.scroll.contentOffset.x / self.view.frame.size.width
        switch segementNum {
        case 0:
            hero.model = self.allHeroArray[indexPath.row]
            break
        default:
            hero.model = self.freeHeroArray[indexPath.row]
        }
        self.navigationController?.pushViewController(hero, animated: true)
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
    func leftAction(){
        self.navigationController?.popViewControllerAnimated(true)
        
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
