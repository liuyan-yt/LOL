//
//  EquipsDetailThirdTableViewCell.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/20.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class EquipsDetailThirdTableViewCell: UITableViewCell {

    
    var descript : UILabel = UILabel()
    let imageStar = UIImageView()
    var newModel = EquipsDetailModel()
    var model : EquipsDetailModel{
        set{
            self.newModel = newValue;
            self.creatImageView()
        }
        get{
            return self.newModel;
        }
        
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 300)
        self.imageStar.frame = CGRectMake(0, 10, 20,20 )
        self.imageStar.image = UIImage.init(named: "星星")
        self.addSubview(self.imageStar)
        self.descript.frame = CGRectMake(CGRectGetMaxX(self.imageStar.frame)+10, 0, self.frame.size.width-self.descript.frame.origin.x, 20)
        self.addSubview(self.descript)
        self.descript.text = "可以合成"
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func creatImageView(){
        
        let array = self.newModel.compose.componentsSeparatedByString(",")
        for i in 0..<array.count {
            let imageView = UIImageView.init(frame: CGRectMake(20+(40+10)*CGFloat(i), CGRectGetMaxY(self.imageStar.frame)+10, 40, 40))
            let str = array[i]
            imageView.sd_setImageWithURL(NSURL.init(string:equipsClassImgUrl1+str+equipsClassImgUrl2))
            self.addSubview(imageView)
        }
        
        
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
