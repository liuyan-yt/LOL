//
//  PersonViewController.swift
//  TheWorld
//
//  Created by 原溢锴 on 16/8/19.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class PersonViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate {
    let icon = UIImageView();
    var value = CGFloat()
    
    override func viewDidAppear(animated: Bool) {
        

        let manager = NightModeManager.Singleton.sharedInstance
        
        if manager.isNight == true {
            self.view.backgroundColor = UIColor.darkGrayColor();
            self.tableView.reloadData();
            
        }else
        {
            self.view.backgroundColor = UIColor.whiteColor();
            self.tableView.reloadData();
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.whiteColor();
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        

        return cell
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView();
        
        let name = UILabel();
        view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width * 0.7,UIScreen.mainScreen().bounds.size.height * 0.25);
        icon.frame = CGRectMake(view.frame.size.height * 0.25 ,view.frame.size.height * 0.25,view.frame.size.height * 0.5 ,view.frame.size.height * 0.5 );
        name.frame = CGRectMake(CGRectGetMaxX(icon.frame) + 10, icon.center.y - 15, UIScreen.mainScreen().bounds.size.width * 0.7 - CGRectGetMaxX(icon.frame) - 10, 30);
        name.text = "测试账号001";
        if icon.image == nil{
        icon.image = UIImage.init(named: "头像占位图");
        }
        icon.userInteractionEnabled = true;
        icon.layer.cornerRadius = view.frame.size.height * 0.25;
        icon.layer.masksToBounds = true;
        
        let gesture = UITapGestureRecognizer();
        gesture.addTarget(self, action: #selector(PersonViewController.gestureAction(_:)))
        gesture.delegate = self;
        icon.addGestureRecognizer(gesture);
        view.addSubview(icon);
        view.addSubview(name);
        return view;
        
        
        
    }
    func gestureAction(ges:UITapGestureRecognizer) -> Void {
        print("点击了头像")
        let picker = UIImagePickerController()
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        self.presentViewController(picker, animated: true, completion: nil);
        
    }
    internal func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        UIImage *temp = [info objectForKey:UIImagePickerControllerOriginalImage];
//        self.imageView.image = temp;
        
        //关闭模态
//        [self dismissViewControllerAnimated:YES completion:nil];
        var temp = UIImage()
        temp = info[UIImagePickerControllerOriginalImage] as! UIImage;
        icon.image = temp;
        self.dismissViewControllerAnimated(true, completion: nil);
        
        
    }
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView();
        
        let nightModeButton = UIButton(type: UIButtonType.Custom);
        view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height * 0.2);
        nightModeButton.frame = CGRectMake(10, 10, view.frame.size.width * 0.3, view.frame.size.height * 0.2);
        nightModeButton.setTitle("夜间模式", forState: UIControlState.Normal);
        nightModeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        nightModeButton.addTarget(self, action: (#selector(PersonViewController.nightModeButtonAction(_:))), forControlEvents: UIControlEvents.TouchUpInside);
        let manager = NightModeManager.Singleton.sharedInstance
        if manager.isNight == true {
            nightModeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
            
        }else
        {
            nightModeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);

        }
        
        view.addSubview(nightModeButton);
        return view;
        
        
        
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200;
    }
    func nightModeButtonAction(sender:UIButton) -> Void {
        
        let manager = NightModeManager.Singleton.sharedInstance
        if manager.isNight == true {
            manager.isNight = false;
            print("日间模式");
            self.viewDidAppear(true)
            value = 0.4;
            UIScreen.mainScreen().brightness = value;
            NSNotificationCenter.defaultCenter().postNotificationName("reload", object: self, userInfo: nil);
            
            
        }else
        {
            manager.isNight = true;
            print("夜间模式")
            self.viewDidAppear(true);
            value = 0.1;
            UIScreen.mainScreen().brightness = value;
            NSNotificationCenter.defaultCenter().postNotificationName("reload", object: self, userInfo: nil);

        }
        
        
        
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.mainScreen().bounds.size.height * 0.25;
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
