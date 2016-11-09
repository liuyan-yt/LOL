//
//  HerosEquipsViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/19.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class HerosEquipsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    lazy var equipsListArray : [EquipsListModel!] = [EquipsListModel]()
    var tableView : UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "装备列表"
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "返回"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HerosEquipsViewController.leftAction));

        
        self.tableView = UITableView.init(frame: CGRectMake(0, -35, self.view.frame.size.width, self.view.frame.size.height), style: UITableViewStyle.Grouped);
       self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.getData()
        // Do any additional setup after loading the view.
    }
    func leftAction(){
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    func getData(){
        let url = NSURL.init(string: equipsListUrl)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if (data != nil){
                let array = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                for item in array{
                    let model = EquipsListModel()
                    model.setValuesForKeysWithDictionary(item as![String : AnyObject])
                    
                    self.equipsListArray.append(model)
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    self.tableView.reloadData()
                })
                
            }
            
        }
        task.resume()
        
    }
    
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.equipsListArray.count
    }
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        }
        let model = self.equipsListArray[indexPath.row]
        cell?.textLabel?.text = model.text
        cell?.detailTextLabel?.text = ">>"
        
        return cell!
        
    }
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let equip = EquipsClassViewController()
        equip.model = self.equipsListArray[indexPath.row]
        self.navigationController?.pushViewController(equip, animated: true)
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
