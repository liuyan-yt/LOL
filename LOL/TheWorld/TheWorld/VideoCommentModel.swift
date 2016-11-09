//
//  VideoCommentModel.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/18.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class VideoCommentModel: NSObject {
    var content = String()
    var created = NSString()
    var good = String()
    var id = String()
    var liked = NSInteger()
    var nickname = String()
    var to = NSDictionary()
    var user_avatar = String()
    var user_id = String()
    var userLogoFrameId = NSInteger()
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}