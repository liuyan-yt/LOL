//
//  ShowDetailViewController.swift
//  TheWorld
//
//  Created by 原溢锴 on 16/8/13.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource{
    override func viewDidAppear(animated: Bool) {
        
        if NightModeManager.Singleton.sharedInstance.isNight == true {
            self.view.backgroundColor = UIColor.blackColor();
            //            self.tableViews.reloadData();
        }else
        {
            self.view.backgroundColor = UIColor.whiteColor();
            //            self.tableViews.reloadData();
        }
    }
    var count : Int = 28;
    var isOpen : Bool = false;
    var indexPath = Int();
    var tableViews = UITableView();
    var size = CGFloat();
    var show = 1
//    var name = UILabel();
//    var genderImage = UIImageView()
//    var icon = UIImageView()

    lazy var modelArray : [CommunityModel]! = [CommunityModel]()
    
    
    var collection = UICollectionView?()
    var dataArray = ["全部大区","艾欧尼亚","祖安","诺克萨斯","班德尔城","皮尔特沃夫","战争学院","巨神峰","雷瑟守备","裁决之地","黑色玫瑰","暗影岛","钢铁烈阳","均衡教派","水晶之痕","影流","守望之海","征服之海","卡拉曼达","皮城守备","比尔吉沃特","德玛西亚","弗雷尔卓德","无畏先锋","恕瑞玛","扭曲丛林","巨龙之巢","教育网专区"];
    var dataArray2 = ["最新","日榜","周榜","总榜"];
    var dataArray3 = ["全部","男","女"];
    lazy var filterArray : [CommunityModel]! = [CommunityModel]();
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
       
        
       collection = UICollectionView.init(frame: CGRectMake(0, 40,UIScreen.mainScreen().bounds.size.width, 500), collectionViewLayout: layout);
        layout.itemSize = CGSizeMake((self.view.frame.size.width - 20)/3, 30);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        collection?.backgroundColor = UIColor.lightGrayColor()
        
        collection?.registerNib(UINib(nibName: "showDetailCell", bundle: nil), forCellWithReuseIdentifier: "cell");
       collection!.hidden = true;
        collection!.delegate = self;
       collection!.dataSource = self;
        
        self.CreateSegment();
        self.tableViews = UITableView.init(frame: CGRectMake(0, 40, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height), style: UITableViewStyle.Grouped);
        self.tableViews.delegate = self;
        self.tableViews.dataSource = self;
        collection?.backgroundColor = UIColor(red: 47.0/255.0, green: 50.0/255.0, blue: 58.0/255.0, alpha: 0.8)
        self.view.addSubview(self.tableViews);
        self.view.addSubview(collection!);
        self.GetData(1);

    }
    func CreateSegment() -> Void {
        let item = ["全部大区","最新","性别"];
        let view = UIView()
        view.frame = CGRectMake(0, 0, Kwidth, 40);
        let button1 = UIButton(type: UIButtonType.Custom);
        button1.frame = CGRectMake(0, 0, Kwidth/3, 40);
        button1.setTitle(item[0], forState: UIControlState.Normal);
        button1.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        button1.addTarget(self, action: #selector(ShowDetailViewController.button1Action(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        let button2 = UIButton(type: UIButtonType.Custom);
        button2.frame = CGRectMake(Kwidth/3, 0, Kwidth/3, 40)
        button2.setTitle(item[1], forState: UIControlState.Normal);
        button2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        button2.addTarget(self, action: #selector(ShowDetailViewController.button2Action(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        let button3 = UIButton(type: UIButtonType.Custom);
        button3.frame = CGRectMake(Kwidth/3*2, 0, Kwidth/3, 40);
        button3.setTitle(item[2], forState: UIControlState.Normal);
        button3.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        button3.addTarget(self, action: #selector(ShowDetailViewController.button3Action(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button1.backgroundColor = UIColor.whiteColor();
        button2.backgroundColor = UIColor.whiteColor();
        button3.backgroundColor = UIColor.whiteColor();
        view.addSubview(button1);
        view.addSubview(button2);
        view.addSubview(button3);
        self.view.addSubview(view);
        
        
        
        
        
        
    }
    func button1Action(sender:UIButton) -> Void {
        if isOpen == true  {
            isOpen = false;
            collection?.hidden = true;
        }
        else{
            isOpen = true;
            count = 28
            self.collection!.hidden = false;

            dispatch_async(dispatch_get_main_queue(), {
                self.collection?.reloadData();
                
            })
        }
    }
    func button2Action(sender:UIButton) -> Void {
        if isOpen == true {
            isOpen = false;
            collection?.hidden = true;
        }else{
            isOpen = true;

            count = 4;
            self.collection!.hidden = false;

            dispatch_async(dispatch_get_main_queue(), {
            self.collection?.reloadData();

                
            })
        }
    }
    func button3Action(sender:UIButton) -> Void {
        if isOpen == true  {
            isOpen = false;
            collection?.hidden = true;
        }else{
            isOpen = true;

            count = 3;
            self.collection!.hidden = false;

            dispatch_async(dispatch_get_main_queue(), {
                self.collection?.reloadData();
                
                
            })

    }
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
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count;
        
    }
    

    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! showDetailCell;
        
            
        
        
        switch count {
        case 28:
            cell.textlabel.text = self.dataArray[indexPath.row];
            break;
        case 4:
           cell.textlabel.text = self.dataArray2[indexPath.row];
            break;
        default:
            cell.textlabel.text = self.dataArray3[indexPath.row];
            break;
        }
        
        cell.backgroundColor = UIColor.clearColor();
        cell.layer.cornerRadius = 5;
        cell.layer.borderColor = UIColor.blackColor().CGColor;
        cell.layer.borderWidth = 1;
        cell.layer.masksToBounds = true;
        return cell
        }
    internal func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        
        switch count {
        case 28:
            self.modelArray.removeAll();
            var area = self.dataArray[indexPath.row];
           area = area.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            let url = NSURL.init(string: "http://lol.zhangyoubao.com/apis/rest/UgcsService/getUserShows?area=\(area)&sex=0&order_kind=0&page=1&page_session=0&i_=KeK%2BB/Egjdvr%2BftuxjqPZQVqjeQo2/E5r6WuC1igLn%2BEVwYpeCvywJm1DzfUYSGpbBgXd0r8OhG0orCTlekOyjWypeW1ATccgCinabgc4oNTS7/bPUDJgfNiVHMrDuIV&t_=1471341810&p_=7775&v_=40090003&d_=ios&osv_=9.1&version=0&a_=lol&api=UgcsService.getUserShows&game=lol&time=1471341810&secretVersion=v1.0&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&nonce=299186&secretSignature=ISyY7Pzv6Q5JrmZBQ5zANn4s7io=")
            let session = NSURLSession.sharedSession();
            let task = session.dataTaskWithURL(url!, completionHandler: { (data, response, error) in
                var dict = NSMutableDictionary()
                dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSMutableDictionary
                let array = dict["data"] as! NSMutableArray;
                for item in array
                {
                    let model = CommunityModel()
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                    self.modelArray.append(model);
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    self.tableViews.reloadData();
                })
            })
            task.resume();
            self.collection?.hidden = true;
            break;
        case 4:
            self.modelArray.removeAll();
            var i = Int()
            
            
            switch indexPath.row {
            case 0:
                i = 0;
                break;
            case 1:
                i = 4;
                break;
            case 2:
                i = 2;
                break;
            default:
                i = 3;
                break;
            }
            let url = NSURL.init(string: "http://lol.zhangyoubao.com/apis/rest/UgcsService/getUserShows?area=&sex=0&order_kind=\(i)&page=1&page_session=0&i_=KeK%2BB/Egjdvr%2BftuxjqPZQVqjeQo2/E5r6WuC1igLn%2BEVwYpeCvywJm1DzfUYSGpbBgXd0r8OhG0orCTlekOyjWypeW1ATccgCinabgc4oNTS7/bPUDJgfNiVHMrDuIV&t_=1471341810&p_=7775&v_=40090003&d_=ios&osv_=9.1&version=0&a_=lol&api=UgcsService.getUserShows&game=lol&time=1471341810&secretVersion=v1.0&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&nonce=299186&secretSignature=ISyY7Pzv6Q5JrmZBQ5zANn4s7io=")
            let session = NSURLSession.sharedSession();
            let task = session.dataTaskWithURL(url!, completionHandler: { (data, response, error) in
                var dict = NSMutableDictionary()
                dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSMutableDictionary
                let array = dict["data"] as! NSMutableArray;
                for item in array
                {
                    let model = CommunityModel()
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                    self.modelArray.append(model);
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableViews.reloadData();
                })
            })
            task.resume();

           
            self.collection?.hidden = true;
            break;
        default:
            self.modelArray.removeAll();
            let url = NSURL.init(string: "http://lol.zhangyoubao.com/apis/rest/UgcsService/getUserShows?area=&sex=\(indexPath.row)&order_kind=0&page=1&page_session=0&i_=KeK%2BB/Egjdvr%2BftuxjqPZQVqjeQo2/E5r6WuC1igLn%2BEVwYpeCvywJm1DzfUYSGpbBgXd0r8OhG0orCTlekOyjWypeW1ATccgCinabgc4oNTS7/bPUDJgfNiVHMrDuIV&t_=1471341810&p_=7775&v_=40090003&d_=ios&osv_=9.1&version=0&a_=lol&api=UgcsService.getUserShows&game=lol&time=1471341810&secretVersion=v1.0&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&nonce=299186&secretSignature=ISyY7Pzv6Q5JrmZBQ5zANn4s7io=")
            let session = NSURLSession.sharedSession();
            let task = session.dataTaskWithURL(url!, completionHandler: { (data, response, error) in
                var dict = NSMutableDictionary()
                dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSMutableDictionary
                let array = dict["data"] as! NSMutableArray;
                for item in array
                {
                    let model = CommunityModel()
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                    self.modelArray.append(model);
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableViews.reloadData();
                })
            })
            task.resume();

            print(indexPath.row)
            self.collection?.hidden = true;
            break;
        }
    }
//===================================================================================================================
//===============================tableView方法========================================================================
//===================================================================================================================
    func GetData(i:Int) -> Void {
        
        
        let url = NSURL.init(string: "\(communityShowURl1)\(i)\(communityShowURl2)")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if (data != nil){
                let dic :NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let array : NSMutableArray = dic["data"] as! NSMutableArray;
                for item in array {
                    let model = CommunityModel()
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                    self.modelArray.append(model)
                    
                }
                
                
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableViews.reloadData()
            })
        }
        task.resume()
    }
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return modelArray.count;
    }
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        var cell = tableView.cellForRowAtIndexPath(indexPath);
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "TableViewCell")
            
            let backView = self.CreatTableView(indexPath);
            cell?.contentView.addSubview(backView)
        }
        
        
        
        return cell!;
        
    }
    func CreatTableView(indexPath:NSIndexPath) -> UIView {
        let backView = UIView()
        
        let icon = UIImageView()
        let name = UILabel()
        let bigImage = UIImageView()
        
        let genderImage = UIImageView()
        icon.frame = CGRectMake(20, 20, Kwidth/7, Kwidth/7);
        icon.layer.cornerRadius = Kwidth/14
        icon.layer.masksToBounds = true;
        let model = modelArray[indexPath.row];
        name.text = model.nickname;
        name.frame = CGRectMake(icon.frame.origin.x + icon.frame.size.width, icon.frame.origin.y, 50, 30);
        name.numberOfLines = 0;
        let maximumLabelSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 20);
        let expectSize = name.sizeThatFits(maximumLabelSize)
        name.frame = CGRectMake(icon.frame.origin.x + icon.frame.size.width + 10,icon.frame.origin.y, expectSize.width, expectSize.height);
        let summoner = UILabel()
        summoner.text = "召唤师 (\(model.area)) \(model.summoner)"
        summoner.frame = CGRectMake(name.frame.origin.x, name.frame.origin.y + name.frame.size.height + 5, 0, 0);
        summoner.numberOfLines = 0;
        summoner.textColor = UIColor.lightGrayColor();
        let maximumLabelSize3 = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 50);
        let expectSize3 = summoner.sizeThatFits(maximumLabelSize3);
        summoner.frame = CGRectMake(name.frame.origin.x, name.frame.origin.y + name.frame.size.height + 5, expectSize3.width, expectSize3.height);
        genderImage.frame = CGRectMake(name.frame.origin.x + name.frame.size.width + 5, name.frame.origin.y, 20, 20);
        if model.sex == "1" {
            genderImage.image = UIImage.init(named: "男")
        }else{
        genderImage.image = UIImage.init(named: "女")
        }
        icon.sd_setImageWithURL(NSURL.init(string: model.avatar));
        bigImage.frame = CGRectMake(icon.frame.origin.x, icon.frame.origin.y + icon.frame.size.height + 10, Kwidth - 40, Kwidth - 40);
        bigImage.sd_setImageWithURL(NSURL.init(string: model.pic_url))
        bigImage.backgroundColor = UIColor.redColor()
        let script = UILabel();
        script.text = model.desc;
        script.frame = CGRectMake(bigImage.frame.origin.x, bigImage.frame.origin.y + bigImage.frame.size.height + 5, 0, 0);
        script.numberOfLines = 0;
        let maximumLabelSize2 = CGSizeMake(bigImage.frame.size.width, 999);
        let expectSize2 = script.sizeThatFits(maximumLabelSize2)
        script.frame = CGRectMake(bigImage.frame.origin.x, bigImage.frame.origin.y + bigImage.frame.size.height + 5, expectSize2.width, expectSize2.height);
        let sepect = UIView()
        sepect.frame = CGRectMake(0, script.frame.origin.y + script.frame.size.height + 5, UIScreen.mainScreen().bounds.size.width, 1);
        sepect.backgroundColor = UIColor.grayColor();
        let Zan = UIImageView()
        Zan.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width / 3 * 2, sepect.frame.origin.y + sepect.frame.size.height + 5, 15, 15);
        let zanCount = UILabel();
        zanCount.frame = CGRectMake(Zan.frame.origin.x + Zan.frame.size.width + 5, Zan.frame.origin.y, 25, 15)
        let comment = UIImageView()
        comment.frame = CGRectMake(zanCount.frame.origin.x + zanCount.frame.size.width + 5, zanCount.frame.origin.y, 15, 15);
        let commentCount = UILabel()
        commentCount.frame = CGRectMake(comment.frame.origin.x + comment.frame.size.width + 5, comment.frame.origin.y, 25, 15);
        zanCount.text = model.good;
        commentCount.text = model.comment
        Zan.image = UIImage.init(named: "赞")
        comment.image = UIImage.init(named: "评论");
        
        backView.addSubview(icon)
        backView.addSubview(name)
        backView.addSubview(genderImage)
        backView.addSubview(bigImage);
        backView.addSubview(script);
        backView.addSubview(sepect);
        backView.addSubview(summoner);
        backView.addSubview(zanCount);
        backView.addSubview(Zan);
        backView.addSubview(comment);
        backView.addSubview(commentCount);
        size = CGRectGetMaxY(commentCount.frame);
       
        
        backView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.height,530);
        
        let manager = AutoLayoutSize()
        manager.size = size;
        print(manager.size)
        return backView
        
    }
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
//        print(manager.size)
        return 530;
    }
    internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let view = ShowListDetailViewController()
        view.models = modelArray[indexPath.row];
        self.navigationController?.pushViewController(view, animated: true);
        
    }

    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView.contentOffset.y < 0) {
            self.GetData(1)
        }else if(scrollView.contentOffset.y >= 0){
            print("加载")
            self.show = self.show + 1
            self.GetData(self.show)
        }
    }
    
    
    
}




