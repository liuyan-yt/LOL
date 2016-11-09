//
//  NavigationViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/11.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor(red: 47.0/255.0, green: 50.0/255.0, blue: 58.0/255.0, alpha: 1);
        self.navigationBar.translucent = false;

        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()];
        self.navigationBar.tintColor = UIColor.whiteColor()
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        
        
        return (self.visibleViewController?.supportedInterfaceOrientations())!
    }
    
    override func shouldAutorotate() -> Bool {
        
        
        return (self.visibleViewController?.shouldAutorotate())!
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
