//
//  EquipsClassViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/19.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class EquipsClassViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var model = EquipsListModel()
    lazy var equipsClassArray : [EquipsClassModel!] = [EquipsClassModel]()
    let layout = UICollectionViewFlowLayout()
    var collection = UICollectionView?()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = model.text
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "返回"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(EquipsClassViewController.leftAction));

        self.layout.itemSize = CGSizeMake((self.view.frame.size.width-50)/4.0, (self.view.frame.size.width-50)/4.0+30);
        self.layout.minimumLineSpacing = 10.0;
        self.layout.minimumInteritemSpacing = 10.0;
        self.layout.scrollDirection = UICollectionViewScrollDirection.Vertical;
        
        
        self.collection = UICollectionView.init(frame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64), collectionViewLayout: self.layout)
        self.view.addSubview(self.collection!)
        self.collection?.registerClass(EquipsClassCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collection?.delegate = self
        self.collection?.dataSource = self
        self.view.backgroundColor = UIColor.whiteColor()
        self.collection?.backgroundColor = UIColor.whiteColor()
        self.getData()
        // Do any additional setup after loading the view.
    }
    func leftAction(){
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    func getData(){
        let url = NSURL.init(string: equipsClassUrl.stringByAppendingString(self.model.tag))
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if data != nil{
                let array = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                for item in array {
                    let model = EquipsClassModel()
                    model.setValuesForKeysWithDictionary(item as![String : AnyObject])
                    self.equipsClassArray.append(model)
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    self.collection?.reloadData()
                })
                
            }
            
        }
        task.resume()
        
        
    }
    
    
    
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.equipsClassArray.count
    }
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! EquipsClassCollectionViewCell
        let model = self.equipsClassArray[indexPath.row]
        cell.model = model;
        cell.text.numberOfLines = 0;
        cell.text.lineBreakMode = NSLineBreakMode.ByTruncatingTail;
        cell.text.font = UIFont.systemFontOfSize(14)
        let width = cell.frame.width-20
            let maximumLabelSize = CGSizeMake(width,40);
            let expectsize = cell.text.sizeThatFits(maximumLabelSize)
            cell.text.frame = CGRectMake(CGRectGetMinX(cell.equipImg.frame), CGRectGetMaxY(cell.equipImg.frame), expectsize.width, expectsize.height);
        cell.text.text = model.text
        return cell
    }
    internal func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let equipsDetail = EquipsDetailViewController()
        equipsDetail.model = self.equipsClassArray[indexPath.row]
        self.navigationController?.pushViewController(equipsDetail, animated: true)
        
        
        
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
