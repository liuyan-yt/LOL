//
//  EquipsClassCollectionViewCell.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/19.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class EquipsClassCollectionViewCell: UICollectionViewCell {
    
    var newModel = EquipsClassModel();
    
    var model: EquipsClassModel {
        set {
            self.newModel = newValue
            self.equipImg.sd_setImageWithURL(NSURL.init(string: equipsClassImgUrl1.stringByAppendingString(String(self.newModel.id)).stringByAppendingString(equipsClassImgUrl2)))
            self.text.text = self.newModel.text
        }
        get {
            return self.newModel
        }
    }
   
    var text = UILabel()
    var equipImg = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.equipImg.frame = CGRectMake(10, 10, self.contentView.frame.width-20, self.contentView.frame.width-20)
        self.contentView.addSubview(self.equipImg)
        self.contentView.addSubview(self.text)    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
