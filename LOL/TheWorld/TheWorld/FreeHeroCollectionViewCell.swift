//
//  FreeHeroCollectionViewCell.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/20.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class FreeHeroCollectionViewCell: UICollectionViewCell {
    var picture =  UIImageView()
    var title = UILabel()
    var cnName = UILabel()
    var location = UILabel()
    var newModel = AllHeroModel();
    
    var model: AllHeroModel {
        set {
            self.newModel = newValue
            self.newModel = newValue
            self.title.text = self.newModel.title
            self.picture.sd_setImageWithURL(NSURL.init(string: heroPictureUrl1+self.newModel.enName+heroPictureUrl2))
            self.cnName.text = self.newModel.cnName
            self.location.text = self.newModel.location
        }
        get {
            return self.newModel
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.picture.frame = CGRectMake(20, 20, 60, 60);
        self.contentView.addSubview(self.picture)
        self.title.frame = CGRectMake(CGRectGetMaxX(self.picture.frame)+5, 10,  self.contentView.frame.width-CGRectGetMaxX(self.picture.frame), 20)
        self.title.textAlignment = NSTextAlignment.Center;
        self.title.font = UIFont.systemFontOfSize(14)
        self.contentView.addSubview(self.title)
        self.cnName.frame = CGRectMake(CGRectGetMinX(self.title.frame),CGRectGetMaxY(self.title.frame) ,CGRectGetWidth(self.title.frame), CGRectGetHeight(self.title.frame)-5)
        self.cnName.textColor = UIColor.lightGrayColor()
        self.cnName.font = UIFont.systemFontOfSize(14)
        self.cnName.textAlignment = NSTextAlignment.Center;
        self.contentView.addSubview(self.cnName)
        self.location.frame = CGRectMake(CGRectGetMinX(self.title.frame),CGRectGetMaxY(self.cnName.frame),CGRectGetWidth(self.title.frame), CGRectGetHeight(self.title.frame)+5)
        self.location.textAlignment = NSTextAlignment.Center;
        self.location.textColor = UIColor(red: 139/255.0, green: 187/255.0, blue: 245/255.0, alpha: 1.0)
        self.location.font = UIFont.systemFontOfSize(14)
        self.contentView.addSubview(self.location)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
