//
//  NightModeManager.swift
//  TheWorld
//
//  Created by 原溢锴 on 16/8/12.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class NightModeManager: NSObject {
    
    var isNight = true
    
        //单例
    class Singleton {
        static let sharedInstance = NightModeManager()
        private init() {} // 阻止其他对象使用这个类的默认的'()'初始化方法
    
    }
}

