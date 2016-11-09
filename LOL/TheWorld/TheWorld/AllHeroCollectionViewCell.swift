//
//  AllHeroCollectionViewCell.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/20.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class AllHeroCollectionViewCell: UICollectionViewCell {
    var picture =  UIImageView()
    var title = UILabel()
    var newModel = AllHeroModel();
    
    var model: AllHeroModel {
        set {
            self.newModel = newValue
            self.title.text = self.newModel.title
            self.picture.sd_setImageWithURL(NSURL.init(string: heroPictureUrl1+self.newModel.enName+heroPictureUrl2))
        }
        get {
            return self.newModel
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.picture.frame = CGRectMake(10, 10, self.contentView.frame.width-20, self.contentView.frame.width-20);
        self.contentView.addSubview(self.picture)
        self.title.frame = CGRectMake(10, CGRectGetMaxY(self.picture.frame)+10,  self.contentView.frame.width-20, 30)
        self.title.textAlignment = NSTextAlignment.Center;
        self.contentView.addSubview(self.title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
