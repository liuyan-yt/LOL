//
//  HeroStrategyViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/25.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class HeroStrategyViewController: UIViewController {
    let web : UIWebView = UIWebView()
    var str : String = String()
    let items = ["高清","超清","流畅"]
    var segment : UISegmentedControl = UISegmentedControl()
    var model : HeroStrategyModel = HeroStrategyModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "返回"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HeroStrategyViewController.leftAction));
        self.segment = UISegmentedControl.init(items: items);
        self.segment.backgroundColor = UIColor.whiteColor()
        self.segment.addTarget(self, action: #selector(InformationsViewController.segmentAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.segment.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
        self.segment.tintColor = UIColor(red: 43.0/255.0, green: 46.0/255.0, blue: 53.0/255.0, alpha: 1)
        self.segment.selectedSegmentIndex = 0;
        self.view.addSubview(self.segment);
        self.view.backgroundColor = UIColor.grayColor()
        self.web.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(web)
        self.view.backgroundColor = UIColor.whiteColor()
       self.getData()
    }
    func leftAction(){
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    func segmentAction(sender:UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            self.getData()
        case 1:
            self.getData1()
        default:
            self.getData2()
        }
    }

    func getData(){
        let url = NSURL.init(string: heroStrategyUrl+self.model.vid)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if data != nil{
                
                let dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let dict = dic["result"]!["items"]!["1000"]!["transcode"] as! NSDictionary
                let array = dict["urls"] as! NSArray
                 self.str = array[0] as! String
                
            }
            dispatch_async(dispatch_get_main_queue(), { 
                let url = NSURL.init(string: self.str)
                let request = NSURLRequest(URL: url!)
                self.web.loadRequest(request)
                print(self.str)
            })
        }
        task.resume()
        
        
    }

    func getData1(){
        let url = NSURL.init(string: heroStrategyUrl+self.model.vid)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if data != nil{
                
                let dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let dict = dic["result"]!["items"]!["1300"]!["transcode"] as! NSDictionary
                let array = dict["urls"] as! NSArray
                self.str = array[0] as! String
                
            }
            dispatch_async(dispatch_get_main_queue(), {
                let url = NSURL.init(string: self.str)
                let request = NSURLRequest(URL: url!)
                self.web.loadRequest(request)
                print(self.str)
            })
        }
        task.resume()
        
        
    }
    func getData2(){
        let url = NSURL.init(string: heroStrategyUrl+self.model.vid)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if data != nil{
                
                let dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let dict = dic["result"]!["items"]!["350"]!["transcode"] as! NSDictionary
                let array = dict["urls"] as! NSArray
                self.str = array[0] as! String
                
            }
            dispatch_async(dispatch_get_main_queue(), {
                let url = NSURL.init(string: self.str)
                let request = NSURLRequest(URL: url!)
                self.web.loadRequest(request)
                print(self.str)
            })
        }
        task.resume()
        
        
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
