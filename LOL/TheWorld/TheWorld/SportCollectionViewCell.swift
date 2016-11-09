//
//  SportCollectionViewCell.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/16.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {
    
    var pic_url =  UIImageView()
    var name = UILabel()
    var newModel = VideoListModel();
    
    var model: VideoListModel {
        set {
            self.newModel = newValue
            let url = NSURL.init(string: self.newModel.pic_url)
            self.pic_url.sd_setImageWithURL(url!)
            self.name.text = self.newModel.name
            if NightModeManager.Singleton.sharedInstance.isNight == true {
                name.textColor = UIColor.whiteColor();
            }else
            {
                name.textColor = UIColor.blackColor();
            }
        }
        get {
            return self.newModel
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.pic_url.frame = CGRectMake(10, 10, self.contentView.frame.width-20, self.contentView.frame.width-20);
        self.contentView.addSubview(self.pic_url)
        self.name.frame = CGRectMake(10, CGRectGetMaxY(self.pic_url.frame)+10, self.contentView.frame.width-20, 30)
        self.name.textAlignment = NSTextAlignment.Center;
        self.contentView.addSubview(self.name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    
}
