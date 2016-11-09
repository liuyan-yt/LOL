//
//  EquipsDetailModel.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/20.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class EquipsDetailModel: NSObject {

    
    
    var allPrice = NSInteger()
    var compose = String()
    var description1 = String()
    var id = String()
    var name = String()
    var need = String()
    var price = NSInteger()
    var sellPrice = NSInteger()
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        super.setValue(value, forKey: key)
        if key == "description"{
            description1 = value as! String
        }
        
    }

}
