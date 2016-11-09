//
//  showDetailCell.swift
//  TheWorld
//
//  Created by 原溢锴 on 16/8/13.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class showDetailCell: UICollectionViewCell {
    var str = String()
    let textlabel = UILabel();
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textlabel.frame = CGRectMake(0, 0,(UIScreen.mainScreen().bounds.size.width)/3, 30);
        textlabel.backgroundColor = UIColor.clearColor();
        self.textlabel.textAlignment = NSTextAlignment.Center;
        self.contentView.addSubview(textlabel);
    }
    override init(frame: CGRect) {
       super.init(frame: frame)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
