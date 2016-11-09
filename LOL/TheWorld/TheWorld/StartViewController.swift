//
//  StartViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/29.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class StartViewController: UIViewController,UIScrollViewDelegate {

    var imageScroll : UIScrollView = UIScrollView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBarHidden = true
        self.imageScroll.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.imageScroll.contentSize = CGSizeMake(self.view.frame.size.width*5, self.view.frame.size.height);
        self.imageScroll.pagingEnabled = true;
        self.imageScroll.alwaysBounceHorizontal = true
        self.imageScroll.delegate = self;
        self.view.addSubview(self.imageScroll)
        self.imageScroll.bounces = false;
        
        for i in 0..<5{
            let imageView = UIImageView.init(frame: CGRectMake(self.view.frame.size.width*CGFloat(i), 0, self.view.frame.size.width, self.view.frame.size.height))
            imageView.image = UIImage.init(named: "引导图"+String(i+1))
            imageView.backgroundColor = UIColor.cyanColor()
            self.imageScroll.addSubview(imageView)
            if i == 4 {
                let button = UIButton(type: UIButtonType.Custom);
                button.setTitle("开始体验", forState: UIControlState.Normal);
                button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
                button.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width * 5 - UIScreen.mainScreen().bounds.width / 2 - 50  , UIScreen.mainScreen().bounds.height - 60, 100, 30);
                button.addTarget(self, action: #selector(StartViewController.buttonAction), forControlEvents: UIControlEvents.TouchUpInside);
                button.backgroundColor = UIColor.redColor();
                self.imageScroll.addSubview(button);
                
            }
        }
        
        // Do any additional setup after loading the view.
    }
//    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if (scrollView.contentOffset.x > self.view.frame.size.width*4) {
//
//            
//        }
//    }
    func buttonAction() -> Void {
    let root = RootViewController()
    let rootController = CQDrawerViewController()
    rootController.leftController = PersonViewController();
    rootController.mainController = root
    self.navigationController?.presentViewController(rootController, animated: true, completion: nil)
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
