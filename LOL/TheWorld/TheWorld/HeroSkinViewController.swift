//
//  HeroSkinViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/23.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class HeroSkinViewController: UIViewController,UIScrollViewDelegate {
    let imageScroll : UIScrollView = UIScrollView();
    lazy var scrImageArray : [ScrImageModel]! = [ScrImageModel]()
    lazy var heroSkinArray : [HeroSkinModel!] = [HeroSkinModel]()
    let width = UIScreen.mainScreen().bounds.width
    let height : CGFloat = UIScreen.mainScreen().bounds.height;
    var model : AllHeroModel = AllHeroModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.buju()
        self.getSkinData()

    
    }
    func buju(){
        self.imageScroll.frame = CGRectMake(0, 0, width, height);
        self.imageScroll.pagingEnabled = true;
        self.imageScroll.alwaysBounceHorizontal = true
        self.imageScroll.delegate = self;
        self.view.addSubview(self.imageScroll)
    }
    
    
    func getSkinData(){
        let url = NSURL.init(string: heroSkinUrl+self.model.enName)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if data != nil{
                
                let array = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                for item in array {
                    let model = HeroSkinModel()
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                    self.heroSkinArray.append(model)
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.imageScroll.contentSize = CGSizeMake(self.width*CGFloat(self.heroSkinArray.count), self.height);
                    self.getSkin()
                })
            }
        }
        task.resume()
        
    }
    func getSkin(){
        for i in 0..<self.heroSkinArray.count{
            let model = self.heroSkinArray[i]
            let imageView = UIImageView.init(frame: CGRectMake(self.width*CGFloat(i), 200, self.width, 200))
            imageView.sd_setImageWithURL(NSURL(string: model.bigImg))
            self.imageScroll.addSubview(imageView)
            let  name = UILabel.init(frame: CGRectMake(self.width*CGFloat(i)+20, CGRectGetMaxY(imageView.frame)+20, 200, 20))
            name.text = model.name
            name.textColor = UIColor.whiteColor()
            self.imageScroll.addSubview(name)
            let price = UILabel.init(frame: CGRectMake(self.width*CGFloat(i)+self.view.frame.size.width-120-20, CGRectGetMaxY(imageView.frame)+20, 120, 20))
            price.text = "点券:"+model.price
            price.textColor = UIColor.whiteColor()
            self.imageScroll.addSubview(price)
            let page = UILabel.init(frame: CGRectMake(self.width*CGFloat(i)+width/2-20, CGRectGetMaxY(price.frame)+50, 40, 20))
            page.text = String(i+1)+"/"+String(self.heroSkinArray.count)
            page.textColor = UIColor.whiteColor()
            self.imageScroll.addSubview(page)
            
        }
        
        
    }
    internal func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
