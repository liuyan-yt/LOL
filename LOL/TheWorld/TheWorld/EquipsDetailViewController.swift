//
//  EquipsDetailViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/20.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class EquipsDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var cellHeight = CGFloat()
    var model : EquipsClassModel = EquipsClassModel()
    var detailModel = EquipsDetailModel()
    lazy var equipsDetailArray : [EquipsDetailModel!] = [EquipsDetailModel]()
    var imageView = UIImageView()
    var tableView = UITableView()
    var tupian = UIImageView()
    var name = UILabel()
    var allPrice = UILabel()
    var sellPrice = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = self.model.text
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "返回"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(EquipsDetailViewController.leftAction));
        self.buju()
        self.getData()

    }
    func buju(){
        
        self.tableView = UITableView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), style: UITableViewStyle.Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(EquipsDetailFirstTableViewCell.self, forCellReuseIdentifier: "first")
        self.tableView.registerClass(EquipsDeatilSecondTableViewCell.self, forCellReuseIdentifier: "second")
        self.tableView.registerClass(EquipsDetailThirdTableViewCell.self, forCellReuseIdentifier: "third")
        self.view.addSubview(self.tableView)
        
    }
    
    
    func getData(){
        let url = NSURL.init(string: equipsDetailUrl+String(self.model.id))
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if data != nil{
            let  dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            let model = EquipsDetailModel()
                
            model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
            self.equipsDetailArray.append(model)
            self.detailModel = self.equipsDetailArray[0]
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.fuzhi()
                self.tableView.reloadData()
            })
        }
        task.resume()
        
        
    }
    func fuzhi(){
        var model = EquipsDetailModel()
        model = self.equipsDetailArray[0]
        self.tupian.sd_setImageWithURL(NSURL.init(string: equipsClassImgUrl1+String(self.model.id)+equipsClassImgUrl2))
        self.name.text = model.name
        self.allPrice.text = "总价格 "+String(model.allPrice)
        self.sellPrice.text = "出售价格 "+String(model.sellPrice)
        
    }
    func leftAction(){
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("first", forIndexPath: indexPath) as! EquipsDetailFirstTableViewCell
            cell.model = self.detailModel
            cell.descriptions.text  = cell.model.description1
            cell.descriptions.numberOfLines = 0;
            cell.descriptions.lineBreakMode = NSLineBreakMode.ByTruncatingTail;
            cell.descriptions.font = UIFont.systemFontOfSize(20)
            let width = self.view.frame.size.width-40
            let maximumLabelSize = CGSizeMake(width, 999);
            let expectsize = cell.descriptions.sizeThatFits(maximumLabelSize)
                cell.descriptions.frame = CGRectMake(20, CGRectGetMaxY(cell.imageStar.frame)+10, expectsize.width, expectsize.height);
            self.cellHeight = CGRectGetMaxY(cell.descriptions.frame)+10
            cell.addSubview(cell.descriptions)

            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier("second", forIndexPath: indexPath) as! EquipsDeatilSecondTableViewCell
            cell.model = self.detailModel


            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("third", forIndexPath: indexPath) as! EquipsDetailThirdTableViewCell
        cell.model = self.detailModel


        return cell
        
        
        
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let backView = UIView()
        backView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200)
        self.imageView.frame = CGRectMake(0, 0,self.view.frame.size.width, 200)
        self.imageView.image = UIImage.init(named: "equipbsck")
        backView.addSubview(self.imageView)
        self.tupian.frame = CGRectMake(20, self.imageView.frame.size.height/2-60, 80, 80)
        backView.addSubview(self.tupian)
        self.name.frame = CGRectMake(CGRectGetMaxX(self.tupian.frame)+20,CGRectGetMinY(self.tupian.frame) , 200, 30)
        backView.addSubview(self.name)
        self.allPrice.frame = CGRectMake(CGRectGetMinX(self.tupian.frame)+10, 200-10-20 , 80, 20)
        self.allPrice.font = UIFont.systemFontOfSize(14)
        backView.addSubview(self.allPrice)
        self.sellPrice.frame = CGRectMake(CGRectGetMaxX(self.allPrice.frame)+30, CGRectGetMinY(self.allPrice.frame), 80, 20)
        self.sellPrice.font = UIFont.systemFontOfSize(12)
        backView.addSubview(self.sellPrice)
        return backView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0{
            return self.cellHeight
        }
        return 90
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
