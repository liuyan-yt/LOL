//
//  RootViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/11.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        let informationsNav = NavigationViewController(rootViewController: InformationsViewController.init());
        informationsNav.tabBarItem = UITabBarItem(title: "资讯", image: UIImage(named: "资讯"), selectedImage: UIImage(named: "资讯"));
        
        let videosNav = NavigationViewController(rootViewController: VideosViewController.init())
        videosNav.tabBarItem = UITabBarItem(title: "视频", image: UIImage(named: "视频"), selectedImage: UIImage(named: "视频"));
        
        let herosNav = NavigationViewController(rootViewController: HerosViewController.init())
        herosNav.tabBarItem = UITabBarItem(title: "英雄", image: UIImage(named: "英雄"), selectedImage: UIImage(named: "英雄"))
        let communityNav = NavigationViewController(rootViewController: CommunityViewController.init())
        communityNav.tabBarItem = UITabBarItem.init(title: "社区", image: UIImage(named: "社区"), selectedImage: UIImage(named: "社区"))
        
        let array = [informationsNav,videosNav,herosNav,communityNav];
        self.viewControllers = array;
        self.tabBar.barTintColor = UIColor(red: 37.0/255.0, green: 40.0/255.0, blue: 46.0/255.0, alpha: 1)
       
        
        
        
        
        
        // Do any additional setup after loading the view.
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
