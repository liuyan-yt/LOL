//
//  PlayTableViewCell.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/15.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class PlayTableViewCell: UITableViewCell {

    
    
    
    
    var title : UILabel = UILabel()
    var comment : UILabel = UILabel()
    let width = UIScreen.mainScreen().bounds.width
    let picture = UIImageView()
    var newModel : LastListModel = LastListModel()
    var model : LastListModel {
        set{
            self.newModel = newValue
            self.title.text = self.newModel.title
            let str = "评论 "
            self.comment.text = str.stringByAppendingString(self.newModel.comment)
            let url = NSURL(string:model.pic_url)
            self.picture.sd_setImageWithURL(url)
            if NightModeManager.Singleton.sharedInstance.isNight == true {
                self.title.textColor = UIColor.whiteColor();
                comment.textColor = UIColor.whiteColor();
            }else
            {
                self.title.textColor = UIColor.blackColor();
                comment.textColor = UIColor.blackColor();
            }
        }
        get{
            return self.newModel
        }
        
        
    }
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.contentView.frame = CGRectMake(0, 0, width, 120)
        
        self.picture.frame = CGRectMake(10, 10, 120, 100);
        self.picture.backgroundColor = UIColor.redColor()
        self.contentView.addSubview(self.picture)
        self.contentView.addSubview(self.title)
        self.comment.frame = CGRectMake(self.contentView.frame.size.width-80-10, self.contentView.frame.size.height-10-20, 80, 20)
        self.contentView.addSubview(self.comment)
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
