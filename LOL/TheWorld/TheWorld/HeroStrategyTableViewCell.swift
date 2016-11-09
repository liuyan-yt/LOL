//
//  HeroStrategyTableViewCell.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/22.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class HeroStrategyTableViewCell: UITableViewCell {
    
    var newModel : HeroStrategyModel = HeroStrategyModel()
    var title = UILabel()
    var cover_url = UIImageView()
    var play_count = UILabel()
    var video = UILabel()
    
    var model : HeroStrategyModel{
        set{
            self.newModel = newValue
            self.cover_url.sd_setImageWithURL(NSURL.init(string:self.newModel.cover_url))
            self.play_count.text = String(self.newModel.play_count)+"评"
        }
        get{
            return self.newModel
        }
        
    
    }
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 120)
        self.cover_url.frame = CGRectMake(10, 10, 100, 100)
        self.addSubview(self.cover_url)
        self.addSubview(self.title)
        self.play_count.frame = CGRectMake(self.frame.size.width-10-60, self.frame.size.height-10-20, 60, 20)
        self.addSubview(self.play_count)
        self.video.frame = CGRectMake(CGRectGetMaxX(self.cover_url.frame)+10, CGRectGetMaxY(self.cover_url.frame)-20, 50, 20)
        self.video.text = "视频"
        self.video.textColor = UIColor.blueColor()
        self.addSubview(self.video)
        
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
