//
//  HeroClassesTableViewCell.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/19.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class HeroClassesTableViewCell: UITableViewCell {
    
    var textImageView = UIImageView()
    var tupianImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, (UIScreen.mainScreen().bounds.height-44-40)/3);
        self.textImageView.frame = CGRectMake(20, 20, 100, self.frame.size.height-60)
        self.contentView.addSubview(self.textImageView)
        self.tupianImageView.frame = CGRectMake(CGRectGetMaxX(self.textImageView.frame)+20, CGRectGetMinY(self.textImageView.frame), self.frame.width-CGRectGetMaxX(self.textImageView.frame)-20-20, self.frame.height-60)
        self.contentView.addSubview(self.tupianImageView)
        self.textImageView.backgroundColor = UIColor.cyanColor()
        self.tupianImageView.backgroundColor = UIColor.greenColor()
        
        
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
