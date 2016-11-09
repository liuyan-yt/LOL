//
//  HeroDetailViewController.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/19.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate {

    var model : AllHeroModel = AllHeroModel()
    let items = ["介绍","攻略","排行"]
    var segment : UISegmentedControl = UISegmentedControl();
    let scroll : UIScrollView = UIScrollView();
    let headView: UIView = UIView()
    var introduce = UITableView()
    var strategy = UITableView()
    var top = UIWebView()
    lazy var detailHeroArray : [DetailHeroModel!] = [DetailHeroModel]()
    lazy var heroStrategyArray : [HeroStrategyModel!] = [HeroStrategyModel]()
    lazy var heroSkillArray : [HeroSkillModel!] = [HeroSkillModel]()
    var picture = UIImageView()
    var name = UILabel()
    var price = UILabel()
    var countOut  = UILabel()
    var skin = UIButton()
    var skillModel = HeroSkillModel()
    var signal : String = "B"
    lazy var indexPath : [NSIndexPath] = [NSIndexPath]();
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let indexPath : NSIndexPath = NSIndexPath.init(forRow: 1, inSection: 3)
        self.indexPath.append(indexPath);
        self.title = self.model.title;
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "返回"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HeroDetailViewController.leftAction));
        self.buju()
        self.getHeadView()
        self.creatTableView()
        self.getData()
        self.getDelegate()
        self.getTop()
    
    }
    
    func buju(){
        self.headView.frame = CGRectMake(0, 0, self.view.frame.size.width, 120)
                  self.view.addSubview(self.headView)
        self.segment = UISegmentedControl.init(items: items);
        self.segment.backgroundColor = UIColor.whiteColor()
        self.segment.addTarget(self, action: #selector(HeroDetailViewController.segmentAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.segment.frame = CGRectMake(0, CGRectGetMaxY(self.headView.frame), self.view.frame.size.width, 40);
        self.segment.tintColor = UIColor(red: 43.0/255.0, green: 46.0/255.0, blue: 53.0/255.0, alpha: 1)
        self.segment.selectedSegmentIndex = 0;
        self.view.addSubview(self.segment);
        
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height-65
        self.scroll.frame = CGRectMake(0, CGRectGetMaxY(self.segment.frame), width, height);
        self.scroll.contentSize = CGSizeMake(width*3, height);
        self.scroll.pagingEnabled = true;
        self.scroll.delegate = self;
        self.scroll.alwaysBounceHorizontal = true;
        self.view.addSubview(self.scroll)
    }

    
    func getHeadView(){
        let imageView = UIImageView.init(frame: CGRectMake(0, 0, self.headView.frame.size.width, self.headView.frame.size.height))
        imageView.image = UIImage.init(named: "背景1")
        self.headView.addSubview(imageView)
        self.picture.frame = CGRectMake(10, 10, 100, 100)
        self.picture.sd_setImageWithURL(NSURL.init(string: heroPictureUrl1+self.model.enName+heroPictureUrl2))
        self.headView.addSubview(self.picture)
        self.name.frame = CGRectMake(120, 10, 200, 30)
        self.name.textColor = UIColor.blackColor()
        self.name.text = self.model.cnName+"-"+self.model.title
        self.headView.addSubview(self.name)
        self.price.frame = CGRectMake(120, 70, 100, 30)
        let array = self.model.price.componentsSeparatedByString(",")
        self.price.textColor = UIColor.blackColor()
        self.price.text = "金币 " + array[0]
        self.headView.addSubview(self.price)
        self.countOut.frame = CGRectMake(230, 70, 100, 30)
        self.countOut.textColor = UIColor.whiteColor()
        self.countOut.text = "点券 " + array[1]
        self.headView.addSubview(self.countOut)
        self.skin = UIButton.init(type: UIButtonType.System)
        var skinImage = UIImage.init(named: "皮肤-line")
        skinImage = skinImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.skin.setImage(skinImage, forState: UIControlState.Normal)
        self.skin.frame = CGRectMake(self.headView.frame
            .size.width-60, self.headView.frame.size.height-60, 40, 40)
        
        self.skin.addTarget(self, action: #selector(HeroDetailViewController.skinAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.headView.addSubview(self.skin)
    }
    func skinAction(){
        
        let skinVC = HeroSkinViewController()
        skinVC.model = self.model
        self.navigationController?.pushViewController(skinVC, animated: true)
        
        
    }
    func creatTableView(){
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height-150
        self.introduce = UITableView(frame: CGRectMake(0, -40, width, height), style: UITableViewStyle.Grouped)
        self.scroll.addSubview(self.introduce);
        self.strategy = UITableView(frame: CGRectMake(width,-40, width, height), style: UITableViewStyle.Grouped)
        self.scroll.addSubview(self.strategy);
        self.top.frame = CGRectMake(width*2, 0, width, self.view.frame.size.height-40-150-65)
        self.scroll.addSubview(self.top);
        
        
    }
    
   
    func getDelegate(){
        
//        let segementNum = self.scroll.contentOffset.x / self.view.frame.size.width
        let a = self.scroll.contentOffset.x

//        switch segementNum {
//        case 0:
//            self.introduce.delegate = self
//            self.introduce.dataSource = self
//            self.introduce.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
//            dispatch_async(dispatch_get_main_queue(), {
//                self.introduce.reloadData()
//            })
//            break
//        case 1:
//            self.strategy.delegate = self
//            self.strategy.dataSource = self
//            self.strategy.registerClass(HeroStrategyTableViewCell.self, forCellReuseIdentifier: "HeroStrategyTableViewCell")
//            dispatch_async(dispatch_get_main_queue(), {
//                self.strategy.reloadData()
//                
//            })
//        default:
//            break
//        }
        
        if a < self.scroll.frame.width {
            self.introduce.delegate = self
            self.introduce.dataSource = self
            self.introduce.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
            dispatch_async(dispatch_get_main_queue(), {
                self.introduce.reloadData()
            })
        }else if a >= self.scroll.frame.width{
            
            self.strategy.delegate = self
            self.strategy.dataSource = self
            self.strategy.registerClass(HeroStrategyTableViewCell.self, forCellReuseIdentifier: "HeroStrategyTableViewCell")
            dispatch_async(dispatch_get_main_queue(), {
                self.strategy.reloadData()
                
            })

            
        }
        
        
        
        
        
    }
    func getTop(){
        let url = NSURL.init(string: heroTopUrl+self.model.enName)
        let request = NSURLRequest(URL: url!)
        
        self.top.loadRequest(request)
        
    }
    
    
    func getData(){
        self.getIntroduceData()

        self.getStrategyData()
    }
    func getIntroduceData(){
        
        let url = NSURL.init(string: heroDetailUrl+self.model.enName)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if data != nil{
                let dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                

                let model = HeroSkillModel()
                
                model.setValueFromDictionary(dic);
//                self.skillModel = model;
                self.heroSkillArray.append(model);
                
                
            
            }
            dispatch_async(dispatch_get_main_queue(), { 
                self.introduce.reloadData()
            })
        }
        task.resume()
        
        
    }
    
    func getStrategyData(){
        
        let url = NSURL.init(string:heroStrategyUrl1+self.model.enName+heroStrategyUrl2)
        print(url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            if data != nil{
                let dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
               
                for item in dic{
                    let model = HeroStrategyModel()
                    model.setValuesForKeysWithDictionary(item as! [String : AnyObject])
                    self.heroStrategyArray.append(model)
                    
                }
                
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.strategy.reloadData()
            })
        }
        task.resume()
    }
    
    func leftAction(){
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    func segmentAction(sender:UISegmentedControl){
        let width = CGFloat(sender.selectedSegmentIndex) * self.view.frame.size.width
        
        self.scroll.setContentOffset(CGPointMake(width, 0), animated: true);
    }
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let segementNum = self.scroll.contentOffset.x / self.view.frame.size.width
        if segementNum == 0 {
            if section == 0 {
                return 2;
            }
            else if section == 1 || section == 2
            {
                return 1
            }else if section == 3
            {
                return 2
            }
        }
        return self.heroStrategyArray.count
    }
    internal func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10;
    }
    internal func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let segementNum = self.scroll.contentOffset.x / self.view.frame.size.width
        if segementNum == 0 {
            if section == 0 {
                return "基本属性"
            }else if  section == 1
            {
                return "被谁克制"
            }else if section == 2
            {
                return "最佳搭档"
            }else if section == 3
            {
                return "技能详情"
            }
            return nil
        }
        return nil
    }
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let segementNum = self.scroll.contentOffset.x / self.view.frame.size.width
//        var cell = tableView.cellForRowAtIndexPath(indexPath);
        if segementNum == 0{
            var cell = tableView.cellForRowAtIndexPath(indexPath);

            if cell == nil {
                cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "cell");
                if self.heroSkillArray.count != 0 {
                
                if indexPath.section == 0 {
                    if indexPath.row == 0 {
                        var view = UIView();
                        view = self.createFirstView(self.heroSkillArray[0] as HeroSkillModel);
                        cell?.addSubview(view);
                        
                    }else
                    {
                        var view = UIView()
                        view = self.CreateSecondView(self.heroSkillArray[0] as HeroSkillModel);
                        cell?.addSubview(view)
                        
                    }
                }else if indexPath.section == 1
                {
                    var view = UIView()
                    view = self.CreateThirdView(self.heroSkillArray[0].likes);
                    cell?.addSubview(view)
                    
                }else if indexPath.section == 2
                {
                    var view = UIView();
                    view = self.CreateThirdView(self.heroSkillArray[0].hates);
                    cell?.addSubview(view);
                    
                }else if indexPath.section == 3
                {
                    if indexPath.row == 0
                {
                    var view = UIView();
                    view = self.CreateForthView(self.heroSkillArray[0] as HeroSkillModel);
                    cell?.addSubview(view);
                    
                    }
                    else
                    {
                        var view = UIView();
                        view = self.createFifthView(self.heroSkillArray[0] as HeroSkillModel);
                        cell?.addSubview(view);
                        
                    }
                    }
                }
            }
                return cell!
            }
            
        let cell = tableView.dequeueReusableCellWithIdentifier("HeroStrategyTableViewCell", forIndexPath: indexPath) as! HeroStrategyTableViewCell
        cell.model = self.heroStrategyArray[indexPath.row]
        cell.title.text = cell.model.title
        cell.title.numberOfLines = 0;
        cell.title.lineBreakMode = NSLineBreakMode.ByTruncatingTail;
        cell.title.font = UIFont.systemFontOfSize(20)
        let width = self.view.frame.size.width-20-100-10
        let maximumLabelSize = CGSizeMake(width, 48.0);
        let expectsize = cell.title.sizeThatFits(maximumLabelSize)
        cell.title.frame = CGRectMake(CGRectGetMaxX(cell.cover_url.frame)+10, 10, expectsize.width, expectsize.height);
        
        return cell

}
     internal func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        let segementNum = self.scroll.contentOffset.x / self.view.frame.size.width
        if segementNum == 0{
            return 4
        }
        
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let segementNum = self.scroll.contentOffset.x / self.view.frame.size.width

        if  segementNum == 0{
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    return 130;
                }else
                {
                    return 180
                }
            }else if indexPath.section == 1{
                return 350;
            }else if indexPath.section == 2
            {
                return 350;
            }else if indexPath.section == 3{
                if indexPath.row == 0
            {
                return 100;
            }else
                {
                    return 200;
                }
            }
        }
        return 120
    
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.introduce.deselectRowAtIndexPath(indexPath, animated:false);
        self.introduce.separatorStyle = UITableViewCellSeparatorStyle.None;
        let segementNum = self.scroll.contentOffset.x / self.view.frame.size.width
        if segementNum == 0{
            
        }else if segementNum == 1{
        let strategy = HeroStrategyViewController()
        strategy.model = self.heroStrategyArray[indexPath.row]
        self.navigationController?.pushViewController(strategy, animated: true)
        }
    }
    internal func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let segementNum = self.scroll.contentOffset.x / self.view.frame.size.width
        self.segment.selectedSegmentIndex = NSInteger(segementNum);
        self.getDelegate()
        
    }
    internal func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.getDelegate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createFirstView(skillModel:HeroSkillModel) -> UIView {
        
        let view = UIView();
        view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width,130 );
        let AD = UILabel();
        let AP = UILabel();
        let HP = UILabel();
        let Difficulty = UILabel();
        let adProgress = UIProgressView();
        let apProgress = UIProgressView();
        let hpProgress = UIProgressView();
        let diProgress = UIProgressView();
        adProgress.progressViewStyle = UIProgressViewStyle.Default;
        AD.frame = CGRectMake(10, 10, 40, 20);
        AP.frame = CGRectMake(10, CGRectGetMaxY(AD.frame) + 10, 40, 20);
        HP.frame = CGRectMake(10, CGRectGetMaxY(AP.frame) + 10, 40, 20);
        Difficulty.frame = CGRectMake(10, CGRectGetMaxY(HP.frame) + 10, 40, 20);
        AD.text = "物理";
        AP.text = "法术";
        HP.text = "生命";
        Difficulty.text = "难度";
        adProgress.transform = CGAffineTransformMakeScale(1.0, 3.0)
        adProgress.frame = CGRectMake(CGRectGetMaxX(AD.frame) + 3, AD.frame.origin.y, UIScreen.mainScreen().bounds.size.width - 10-CGRectGetMaxX(AD.frame) - 3, AD.frame.size.height);
        apProgress.frame = CGRectMake(adProgress.frame.origin.x, AP.frame.origin.y, adProgress.frame.size.width, adProgress.frame.size.height);
        hpProgress.frame = CGRectMake(adProgress.frame.origin.x, HP.frame.origin.y, adProgress.frame.size.width, adProgress.frame.size.height);
        diProgress.frame = CGRectMake(adProgress.frame.origin.x, Difficulty.frame.origin.y, adProgress.frame.size.width, adProgress.frame.size.height);
        adProgress.progressTintColor = UIColor.yellowColor();
        apProgress.progressTintColor = UIColor.orangeColor();
        hpProgress.progressTintColor = UIColor.blueColor();
        diProgress.progressTintColor = UIColor.greenColor();
        adProgress.progress = Float(skillModel.ratingAttack)! / 10.0;
        apProgress.progress = Float(skillModel.ratingMagic)! / 10.0;
        hpProgress.progress = Float(skillModel.ratingDefense)! / 10.0;
        diProgress.progress = Float(skillModel.ratingDifficulty)! / 10.0;
        view.addSubview(AD);
        view.addSubview(AP);
        view.addSubview(HP);
        view.addSubview(Difficulty);
        view.addSubview(adProgress);
        view.addSubview(apProgress);
        view.addSubview(hpProgress);
        view.addSubview(diProgress);
        return view;
        
        
    }
    func CreateSecondView(skillModel:HeroSkillModel) -> UIView {
        let HP = UILabel()
        let ADSpeed = UILabel();
        let HPRegen = UILabel();
        let Range = UILabel();
        let MP = UILabel();
        let Armor = UILabel();
        let MPRegen = UILabel();
        let MPRegist = UILabel();
        let AD = UILabel();
        let MoveSpeed = UILabel();
        HP.frame = CGRectMake(20, 20, (UIScreen.mainScreen().bounds.width - 40) / 2, 30);
        ADSpeed.frame = CGRectMake((UIScreen.mainScreen().bounds.width - 40) / 2, 20,(UIScreen.mainScreen().bounds.width - 40) / 2, 30);
        HPRegen.frame = CGRectMake(HP.frame.origin.x, CGRectGetMaxY(HP.frame), (UIScreen.mainScreen().bounds.width - 40) / 2, 30);
        Range.frame = CGRectMake(ADSpeed.frame.origin.x, HPRegen.frame.origin.y, (UIScreen.mainScreen().bounds.width - 40) / 2, 30);
        MP.frame = CGRectMake(HP.frame.origin.x, CGRectGetMaxY(HPRegen.frame), (UIScreen.mainScreen().bounds.width - 40) / 2, 30);
        Armor.frame = CGRectMake(Range.frame.origin.x, MP.frame.origin.y, (UIScreen.mainScreen().bounds.width - 40) / 2, 30);
        MPRegen.frame = CGRectMake(HP.frame.origin.x, CGRectGetMaxY(MP.frame), (UIScreen.mainScreen().bounds.width - 40) / 2, 30);
        MPRegist.frame = CGRectMake(Armor.frame.origin.x, MPRegen.frame.origin.y, (UIScreen.mainScreen().bounds.width - 40) / 2, 30);
        AD.frame = CGRectMake(HP.frame.origin.x, CGRectGetMaxY(MPRegen.frame), (UIScreen.mainScreen().bounds.width - 40) / 2, 30);
        MoveSpeed.frame = CGRectMake(MPRegist.frame.origin.x, AD.frame.origin.y, (UIScreen.mainScreen().bounds.width - 40) / 2, 30);
        HP.text = "生命值:\(skillModel.healthBase)";
        ADSpeed.text = "暴击率:\(skillModel.criticalChanceBase)";
        HPRegen.text = "生命恢复:\(skillModel.healthRegenBase)";
        Range.text = "攻击范围:\(skillModel.range)";
        MP.text = "法力值:\(skillModel.manaBase)";
        Armor.text = "护甲值:\(skillModel.armorBase)";
        MPRegen.text = "法力回复:\(skillModel.manaRegenBase)";
        MPRegist.text = "法术抗性:\(skillModel.magicResistBase)";
        AD.text = "攻击力:\(skillModel.attackBase)";
        MoveSpeed.text = "移动速度:\(skillModel.moveSpeed)";
        let view = UIView();
        view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 180);
        view.addSubview(HP);
        view.addSubview(ADSpeed);
        view.addSubview(HPRegen);
        view.addSubview(Range);
        view.addSubview(MP);
        view.addSubview(Armor);
        view.addSubview(MPRegen);
        view.addSubview(MPRegist);
        view.addSubview(AD);
        view.addSubview(MoveSpeed);
        
        return view;
  
        
    }
    func CreateThirdView(array:NSMutableArray) -> UIView {
        let model1 : LikeModel = array[0] as! LikeModel;
        let model2 : LikeModel = array[1] as! LikeModel;
        
        
        let icon1 = UIImageView();
        let icon2 = UIImageView();
        let content1 = UILabel();
        let content2 = UILabel();
        let view = UIView()
        view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 200);
        icon1.frame = CGRectMake(10, 10, 50, 50)
        content1.text = model1.des;
        content1.numberOfLines = 0;
        
        let maxSize = CGSizeMake(view.frame.size.width - 80, 999);
        let expectSize = content1.sizeThatFits(maxSize);
        content1.frame = CGRectMake(CGRectGetMaxX(icon1.frame) + 10, icon1.frame.origin.y, expectSize.width, expectSize.height);
        icon2.frame = CGRectMake(icon1.frame.origin.x, CGRectGetMaxY(content1.frame) + 10, 50, 50);
        content2.text = model2.des;
        content2.numberOfLines = 0;
        let expectSize2 = content2.sizeThatFits(maxSize);
        content2.frame = CGRectMake(content1.frame.origin.x, icon2.frame.origin.y, expectSize2.width, expectSize2.height);
        icon1.sd_setImageWithURL(NSURL.init(string: "\(heroPictureUrl1)\(model1.partner)\(heroPictureUrl2)"));
        icon2.sd_setImageWithURL(NSURL.init(string: "\(heroPictureUrl1)\(model2.partner)\(heroPictureUrl2)"));
        view.addSubview(icon1);
        view.addSubview(icon2);
        view.addSubview(content1);
        view.addSubview(content2);
        return view;
        
    }
    func CreateForthView(skillModel:HeroSkillModel) -> UIView {
        let view = UIView();
        let button_B = UIButton.init(type: UIButtonType.Custom);
        let button_Q = UIButton.init(type: UIButtonType.Custom);
        let button_W = UIButton.init(type: UIButtonType.Custom);
        let button_E = UIButton.init(type: UIButtonType.Custom);
        let button_R = UIButton.init(type: UIButtonType.Custom);
        let image1 = UIImageView();
        let image2 = UIImageView();
        let image3 = UIImageView();
        let image4 = UIImageView();
        let image5 = UIImageView();
        view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 100);
        image1.frame = CGRectMake(0, 0, 50, 50);
        image2.frame = CGRectMake(0, 0, 50, 50);
        image3.frame = CGRectMake(0, 0, 50, 50);
        image4.frame = CGRectMake(0, 0, 50, 50);
        image5.frame = CGRectMake(0, 0, 50, 50);
        button_B.frame = CGRectMake(10, 10, 50, 50);
        button_Q.frame = CGRectMake(CGRectGetMaxX(button_B.frame) + 10, button_B.frame.origin.y, 50, 50);
        button_W.frame = CGRectMake(CGRectGetMaxX(button_Q.frame) + 10, button_Q.frame.origin.y, 50, 50);
        button_E.frame = CGRectMake(CGRectGetMaxX(button_W.frame) + 10, button_Q.frame.origin.y, 50, 50);
        button_R.frame = CGRectMake(CGRectGetMaxX(button_E.frame) + 10, button_Q.frame.origin.y, 50, 50);
        image1.sd_setImageWithURL(NSURL.init(string: "\(KUnion_Ency_HeroSkillImageURL1)\(skillModel.name)_B\(KUnion_Ency_HeroSkillImageURL2)"))
        image2.sd_setImageWithURL(NSURL.init(string: "\(KUnion_Ency_HeroSkillImageURL1)\(skillModel.name)_Q\(KUnion_Ency_HeroSkillImageURL2)"))
        image3.sd_setImageWithURL(NSURL.init(string: "\(KUnion_Ency_HeroSkillImageURL1)\(skillModel.name)_W\(KUnion_Ency_HeroSkillImageURL2)"))
        image4.sd_setImageWithURL(NSURL.init(string: "\(KUnion_Ency_HeroSkillImageURL1)\(skillModel.name)_E\(KUnion_Ency_HeroSkillImageURL2)"))
        image5.sd_setImageWithURL(NSURL.init(string: "\(KUnion_Ency_HeroSkillImageURL1)\(skillModel.name)_R\(KUnion_Ency_HeroSkillImageURL2)"))
        button_B.addSubview(image1)
        button_Q.addSubview(image2);
        button_W.addSubview(image3);
        button_E.addSubview(image4);
        button_R.addSubview(image5);
        button_B.addTarget(self, action: #selector(HeroDetailViewController.button1Action(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button_Q.addTarget(self, action: #selector(HeroDetailViewController.button2Action(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button_W.addTarget(self, action: #selector(HeroDetailViewController.button3Action(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button_E.addTarget(self, action: #selector(HeroDetailViewController.button4Action(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button_R.addTarget(self, action: #selector(HeroDetailViewController.button5Action(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        view.addSubview(button_B);
        view.addSubview(button_Q);
        view.addSubview(button_W);
        view.addSubview(button_E);
        view.addSubview(button_R);
        return view;
        
        
        
        
        
        
    }
    func createFifthView(skillModel:HeroSkillModel) -> UIView {
        let view = UIView();
        view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 200);
        let name = UILabel();
        name.frame = CGRectMake(10, 10, UIScreen.mainScreen().bounds.width - 20, 30);
        let content = UILabel();
        content.numberOfLines = 0;
        
        switch self.signal {
        case "B":
            name.text = skillModel.skill_B.name;
            content.text = skillModel.skill_B.descriptions;
            break;
        case "Q":
            name.text = skillModel.skill_Q.name;
            content.text = skillModel.skill_Q.descriptions;

            break;
            case "W":
                name.text = skillModel.skill_W.name;
                content.text = skillModel.skill_W.descriptions;

                break;
            case "E":
                name.text = skillModel.skill_E.name;
                content.text = skillModel.skill_E.descriptions;

                break;
        default:
            name.text = skillModel.skill_R.name;
            content.text = skillModel.skill_R.descriptions;

            break;
        }
        let maxSize = CGSizeMake(UIScreen.mainScreen().bounds.width - 20, 999);
        let expectSize = content.sizeThatFits(maxSize);
        content.frame = CGRectMake(10, CGRectGetMaxY(name.frame) + 10, expectSize.width, expectSize.height);
        view.addSubview(name);
        view.addSubview(content);
        return view;
        
        
        
        
    }
    func button1Action(sender:UIImageView) -> Void {
        let segementNum = self.scroll.contentOffset.x / self.view.frame.size.width
        if segementNum == 0 {
            self.signal = "B";
//            self.introduce.reloadRowsAtIndexPaths(self.indexPath, withRowAnimation: UITableViewRowAnimation.None)
            self.introduce.reloadData();
        }
       
    }
    func button2Action(sender:UIImageView) -> Void {
        self.signal = "Q";
        self.introduce.reloadData();

    }
    func button3Action(sender:UIImageView) -> Void {
        self.signal = "W";
        self.introduce.reloadData();

    }
    func button4Action(sender:UIImageView) -> Void {
        self.signal = "E";
        self.introduce.reloadData();

    }
    func button5Action(sender:UIImageView) -> Void {
        self.signal = "R";
        self.introduce.reloadData();

    }
//    func createSecondView(skillModel:HeroSkillModel,number:Int) -> Void {
//        let skillName = UILabel();
//        skillName.frame = CGRectMake(10, 10, UIScreen.mainScreen().bounds.size.width - 20, 22);
//        switch number {
//        case 0:
//            skillName.text = skillModel.skill_B.name + "[被动]";
//            break;
//        case 1:
//            skillName.text = skillModel.skill_Q.name + "[Q]";
//            break;
//        case 2:
//            skillName.text = skillModel.skill_W.name + "[W]";
//            break;
//        case 3:
//            skillName.text = skillModel.skill_E.name + "[E]";
//            break;
//        default:
//            skillName.text = skillModel.skill_R.name + "[R]";
//            break;
//        }
//        
//    }
    

    

}
