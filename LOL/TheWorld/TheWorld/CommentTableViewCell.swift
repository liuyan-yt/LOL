//
//  CommentTableViewCell.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/25.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    var user_avatar = UIImageView()
    var nickname = UILabel()
    var created = UILabel()
    var content = UILabel()
    var to = UIView()
    var toNickname = UILabel()
    var toContent = UILabel()
    var good = UILabel()
    var goodImg = UIImageView()
    var newModel = CommentModel()
    var model : CommentModel {
        set{
            self.newModel = newValue
            user_avatar.sd_setImageWithURL(NSURL.init(string: self.newModel.user_avatar))
            self.nickname.text = self.newModel.nickname
            self.created.text = self.newModel.created.substringToIndex(10)
            self.content.text = self.newModel.content
            self.toNickname.text = self.newModel.to["nickname"] as? String
            self.toContent.text = self.newModel.to["content"] as? String
            self.good.text = self.newModel.good
            if NightModeManager.Singleton.sharedInstance.isNight == true {
                nickname.textColor = UIColor.whiteColor();
                content.textColor = UIColor.whiteColor();
                toNickname.textColor = UIColor.cyanColor();
                toContent.textColor = UIColor.whiteColor();
            }else
            {
                nickname.textColor = UIColor.blackColor();
                content.textColor = UIColor.blackColor();
                toNickname.textColor = UIColor(red: 83/255.0, green: 167/255.0, blue: 223/255.0, alpha: 1.00);
                toContent.textColor = UIColor.blackColor();
            }
            
        }
        get{
            return self.newModel
        }
        
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 100)
        self.user_avatar.frame = CGRectMake(20, 20, 60, 60)
        self.user_avatar.layer.cornerRadius = 30
        self.user_avatar.layer.masksToBounds = true
        self.contentView.addSubview(self.user_avatar)
        
        
        self.nickname.frame = CGRectMake(CGRectGetMaxX(self.user_avatar.frame)+10,20,150,20)
        self.nickname.font = UIFont.systemFontOfSize(14)
        self.contentView.addSubview(self.nickname)
        self.created.frame = CGRectMake(CGRectGetMinX(self.nickname.frame), 40, 150, 20)
        self.created.font = UIFont.systemFontOfSize(12)
        self.created.textColor = UIColor.grayColor()
        self.contentView.addSubview(self.created)
        self.good.frame = CGRectMake(self.frame.size.width-10-20, 10, 20, 20)
        self.good.textColor = UIColor(red: 213/255.0, green: 214/255.0, blue: 218/255.0, alpha: 0.600)
        self.good.font = UIFont.systemFontOfSize(16)
        self.contentView.addSubview(self.good)
        self.goodImg.frame = CGRectMake(CGRectGetMinX(self.good.frame)-20-5, 10, 20, 20)
        self.goodImg.image = UIImage.init(named: "赞")
        self.contentView.addSubview(self.goodImg)
        
        
        self.contentView.addSubview(self.content)
        self.contentView.addSubview(self.to)
        self.to.addSubview(self.toContent)
        self.toNickname.textColor = UIColor(red: 83/255.0, green: 167/255.0, blue: 223/255.0, alpha: 1.00)
        self.toNickname.font = UIFont.systemFontOfSize(12)
        self.to.addSubview(self.toNickname)
        self.to.backgroundColor = UIColor(red: 213/255.0, green: 214/255.0, blue: 218/255.0, alpha: 0.600)
        
        
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
