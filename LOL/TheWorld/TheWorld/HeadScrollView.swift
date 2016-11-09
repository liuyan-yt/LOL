//
//  HeadScrollView.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/14.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class HeadScrollView: UIView,UIScrollViewDelegate {
    let imageScroll : UIScrollView = UIScrollView();
    lazy var scrImageArray : [ScrImageModel]! = [ScrImageModel]()
    let imageArray = NSMutableArray()
    let page : UIPageControl = UIPageControl()
    
    
    
    let width = UIScreen.mainScreen().bounds.width
    let height : CGFloat = 180.0;
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRectMake(0, 0, width, height)
        self.imageScroll.frame = CGRectMake(0, 0, width, height);
        self.imageScroll.pagingEnabled = true;
        self.imageScroll.alwaysBounceHorizontal = true
        self.imageScroll.delegate = self;
        self.addSubview(self.imageScroll)
        self.page.frame = CGRectMake(20, self.frame.size.height - 30,self.frame.size.width - 40, 20)
      
        self.page.addTarget(self, action: #selector(HeadScrollView().pageAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.addSubview(page)
        
        
        self.getScrImageData()
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
    }
    func getScrImageData(){
        
        let url = NSURL(string: informationScrollUrl)
        let session = NSURLSession.sharedSession()
        let task : NSURLSessionTask = session.dataTaskWithURL(url!, completionHandler: { (data, response, error) in
            if ((data) != nil){
                let dic : NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let array : NSMutableArray = dic["data"] as! NSMutableArray;
                for item in array {
                    let model = ScrImageModel()
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                    self.scrImageArray.append(model)
                    let str = model.pic_ad_url
                    self.imageArray.addObject(str)
                }
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.imageScroll.contentSize = CGSizeMake(self.width*CGFloat(self.scrImageArray.count), self.height);
                self.page.numberOfPages = self.scrImageArray.count
            for i in 0..<self.scrImageArray.count{
                    let imageView = UIImageView.init(frame: CGRectMake(self.width*CGFloat(i), 0, self.width, self.height))
                    imageView.sd_setImageWithURL(NSURL(string: self.imageArray[i] as! String))
                    self.imageScroll.addSubview(imageView)
                
                    }
            })

        });
        

        task.resume();
        
    }
    
    internal func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let segementNum = scrollView.contentOffset.x / self.width
        self.page.currentPage = NSInteger(segementNum);
        
        
    }
    
    func pageAction(sender:UIPageControl){
        self.imageScroll.setContentOffset(CGPointMake(CGFloat(sender.currentPage)*width, 0), animated: true);
        
    }
    

    
}
