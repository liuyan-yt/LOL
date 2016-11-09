//
//  HeroRunesTableViewCell.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/19.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class HeroRunesTableViewCell: UITableViewCell {

    
    var newModel : HeroRunesModel = HeroRunesModel()
    var model : HeroRunesModel {
        set{
            self.newModel = newValue

            var str = "http://img.lolbox.duowan.com/runes/"
            str = str.stringByAppendingString(self.newModel.Img)
            str = str.stringByAppendingString("_")
            if self.newModel.Type == 4 {
                self.newModel.Type = 3
            }
            str = str.stringByAppendingString(String(self.newModel.Type))
            str = str.stringByAppendingString(".png")
            self.runesImg.sd_setImageWithURL(NSURL.init(string: str))
            self.name.text = self.newModel.Name
            let str1 = "金币:"
            let str2 = "属性: "
            switch self.newModel.Type {
            case 1:
                if self.newModel.lev1.isEmpty{
                    self.price.text = "金币:(已移除)"
                    self.price.frame = CGRectMake(CGRectGetMaxX(self.frame)-135, 30, 120, 30)
                }else{
                    self.price.text = str1.stringByAppendingString(String(self.newModel.iplev1))
                }
                self.describe.text = str2.stringByAppendingString(self.newModel.lev1).stringByAppendingString(self.newModel.Units).stringByAppendingString(self.newModel.Prop)
                
                break
            case 2:
                self.describe.text = str2.stringByAppendingString(self.newModel.lev2).stringByAppendingString(self.newModel.Units).stringByAppendingString(self.newModel.Prop)
                if self.newModel.lev2.isEmpty{
                    self.price.text = "金币:(已移除)"
                    self.price.frame = CGRectMake(CGRectGetMaxX(self.frame)-135, 30, 120, 30)
                }else{
                    self.price.text = str1.stringByAppendingString(String(self.newModel.iplev2))
                }

                break
            case 3:
                self.describe.text = str2.stringByAppendingString(self.newModel.lev3).stringByAppendingString(self.newModel.Units).stringByAppendingString(self.newModel.Prop)
                self.price.text = str1.stringByAppendingString(String(self.newModel.iplev3))

            default:
                break
            }
            
        }
        get{
            return self.newModel
        }
        
        
    }
    

    let backView : UIView = UIView()
    var runesImg : UIImageView = UIImageView()
    let name : UILabel = UILabel()
    let describe : UILabel = UILabel()
    let price : UILabel = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 100)
        self.backgroundColor = UIColor(red: 26/250.0, green: 48/250.0, blue: 91/250.0, alpha: 1.0)
        self.backView.frame = CGRectMake(5, 5, self.frame.width-10, self.frame.height-10)
        self.backView.backgroundColor = UIColor.whiteColor()
        self.addSubview(self.backView)
        self.runesImg.frame = CGRectMake(10, 10, 70, 70)
        self.backView.addSubview(self.runesImg)
        
        self.name.frame = CGRectMake(CGRectGetMaxX(self.runesImg.frame)+10, 10, 120, 30);
        self.backView.addSubview(self.name)
        self.describe.frame = CGRectMake(CGRectGetMinX(self.name.frame),CGRectGetMaxY(self.name.frame), 200, 30)
        self.describe.font = UIFont.systemFontOfSize(16)
        self.backView.addSubview(self.describe)
        self.price.frame = CGRectMake(CGRectGetMaxX(self.frame)-105, 30, 90, 30)
        self.backView.addSubview(self.price)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
