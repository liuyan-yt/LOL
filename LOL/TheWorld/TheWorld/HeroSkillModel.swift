//
//  HeroSkillModel.swift
//  TheWorld
//
//  Created by 原溢锴 on 16/8/25.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class SkillModel: NSObject {
    var cooldown = String();
    var cost = String();
    var descriptions = String();
    var effect = String();
    var id = String();
    var name = String();
    var range = String()
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        
        
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "description" {
            descriptions = value as! String;
        }
    }
  
    
}

class HeroSkillModel: NSObject {
    var skill_Q = SkillModel();
    var skill_W = SkillModel();
    var skill_B = SkillModel();
    var skill_E = SkillModel();
    var skill_R = SkillModel();
    var armorBase = String();
    var armorLevel = String();
    var attackBase = String();
    var attackLevel = String();
    var criticalChanceBase = String();
    var criticalChanceLevel = String();
    var descriptions = String();
    var displayName = String();
    var hates = NSMutableArray();
    var healthBase = String();
    var healthLevel = String();
    var healthRegenBase = String();
    var healthRegenLevel = String();
    var likes = NSMutableArray()
    var magicResistBase = String();
    var magicResistLevel = String();
    var manaBase = String();
    var manaLevel = String();
    var manaRegenBase = String();
    var manaRegenLevel = String();
    var moveSpeed = String();
    var name = String();
    var opponentTips = String();
    var price = String();
    var range = String();
    var ratingAttack = String();
    var ratingDefense = String();
    var ratingDifficulty = String();
    var ratingMagic = String();
    var tags = String();
    var tips = String();
    var title = String()
    var skillNameArray = NSMutableArray();
    
    
     func setValueFromDictionary(dictionary:NSDictionary) -> Void {
        let name = dictionary["name"];
        let allkey = dictionary.allKeys;
        
        self.setValuesForKeysWithDictionary(dictionary as! [String : AnyObject]);
        for item in dictionary["like"] as! NSMutableArray {
            let model = LikeModel();
            model.setValuesForKeysWithDictionary(item as! [String:AnyObject]);
            likes.addObject(model)
            
            
        }
        for item in dictionary["hate"] as! NSMutableArray {
            let model = LikeModel();
            model.setValuesForKeysWithDictionary(item as! [String:AnyObject]);
            hates.addObject(model)
            
            
        }
        
        for item : String in allkey as! [String!] {
            
            switch item {
                case "\(name as! String)_B":
                    
                    
                    skill_B.setValuesForKeysWithDictionary(dictionary[item]! as! [String : AnyObject]);
                
                    
                break;
                case "\(name as! String)_Q":
                    skill_Q.setValuesForKeysWithDictionary(dictionary[item]! as![String : AnyObject]);
                    break;
                case "\(name as! String)_W":
                    skill_W.setValuesForKeysWithDictionary(dictionary[item]! as![String : AnyObject]);
                    break;
                case "\(name as! String)_E":
                    skill_E.setValuesForKeysWithDictionary(dictionary[item]! as![String : AnyObject]);
                    break;
                case "\(name as! String)_R":
                    skill_R.setValuesForKeysWithDictionary(dictionary[item]! as![String : AnyObject]);
                    break;
            default:
                break;
            }
            
            
        }
        
        
        
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
//    override func setValue(value: AnyObject?, forKey key: String) {
//        if key == "description" {
//            descriptions = value as! String;
//        }
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
