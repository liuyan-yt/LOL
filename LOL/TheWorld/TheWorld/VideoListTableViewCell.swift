//
//  VideoListTableViewCell.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/16.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class VideoListTableViewCell: UITableViewCell {
    
    var title : UILabel = UILabel()
    var pic_url : UIImageView = UIImageView()
    var video : UILabel = UILabel()
    let width = UIScreen.mainScreen().bounds.width

    var newModel : VideoDetailModel = VideoDetailModel()
    var model : VideoDetailModel {
        set{
            self.newModel = newValue
            self.title.text = self.newModel.title
            let url = NSURL(string:newModel.pic_url)
            self.pic_url.sd_setImageWithURL(url)
            if NightModeManager.Singleton.sharedInstance.isNight == true {
                title.textColor = UIColor.whiteColor();
                video.textColor = UIColor.cyanColor();
                video.layer.borderColor = UIColor.cyanColor().CGColor;
            }else
            {
                title.textColor = UIColor.blackColor();
                video.textColor = UIColor.blueColor();
                video.layer.borderColor = UIColor.blueColor().CGColor;
            }
           
        }
        get{
            return self.newModel
        }
        
        
    }
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.contentView.frame = CGRectMake(0, 0, width, 120)
        self.pic_url.frame = CGRectMake(10, 10, 150, 100)
        self.contentView.addSubview(self.pic_url)
        self.video.frame = CGRectMake(CGRectGetMaxX(self.pic_url.frame)+10, self.contentView.frame.size.height-10-20, 50, 20);
        self.video.text = "视频"
        
        self.video.layer.borderWidth = CGFloat(0.5);
        self.video.layer.masksToBounds = true;
        self.video.textColor = UIColor.blueColor()
        self.contentView.addSubview(self.video)
        self.contentView.addSubview(self.title)
        

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
