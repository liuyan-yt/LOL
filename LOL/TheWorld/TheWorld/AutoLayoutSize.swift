//
//  AutoLayoutSize.swift
//  TheWorld
//
//  Created by 原溢锴 on 16/8/16.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class AutoLayoutSize: NSObject {

    var size : CGFloat = 2.2
    
    
    static var sharedInstance : AutoLayoutSize {
        struct Static {
            static let instance : AutoLayoutSize = AutoLayoutSize()
        }
        return Static.instance
    }
}
