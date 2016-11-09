//
//  VideoPlayViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/17.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class VideoPlayViewController: UIViewController {

    var str = String()
    let web : UIWebView = UIWebView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "返回"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(VideoPlayViewController.leftAction));
        self.view.backgroundColor = UIColor.grayColor()
        self.web.frame = CGRectMake(0, -40, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(web)
        let url = NSURL.init(string: self.str)
        let request = NSURLRequest(URL: url!)
        self.web.loadRequest(request)
        self.view.backgroundColor = UIColor.whiteColor()
        
    
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
