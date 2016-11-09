//
//  CollectionManager.swift
//  TheWorld
//
//  Created by 原溢锴 on 16/8/20.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import UIKit

class CollectionManager: NSObject {
    var dataBase = FMDatabase();
    var dbPath = String()
    
    
    

    
    class Singleton {
        static let sharedInstance = CollectionManager()
        private init() {} // 阻止其他对象使用这个类的默认的'()'初始化方法
    }
    
    func CreateDB() -> Bool {
         let documentPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentPath = documentPaths[0]
        let path = documentPath.stringByAppendingString("/collection.sqlite")
        self.dbPath = path;
        self.dataBase = FMDatabase(path: path);
        self.dataBase.open();
        print(self.dbPath);
        return true;
    
    }
    func CreateTable() -> Bool {
        
        let createSql : String = "CREATE TABLE IF NOT EXISTS Collection ('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT , 'title' TEXT NOT NULL , 'image' TEXT,  'URL' TEXT NOT NULL)";
        if self.dataBase.executeUpdate(createSql, withArgumentsInArray: nil) {
            print("数据库创建成功!")
            return true;
        }else
        {
            print("数据库创建失败!")
            return false;
        }
        
    }
   
    func selectAllOfData() -> NSMutableArray {
        self.dataBase.open()
        let dataArray = NSMutableArray()
        var resultSet = FMResultSet()
        resultSet = self.dataBase.executeQuery("select * from collection", withArgumentsInArray: nil);
        while resultSet.next() {
            
            let image = resultSet.stringForColumn("image");
            let title = resultSet.stringForColumn("title");
            let url = resultSet.stringForColumn("URL");
            let dataDict : NSMutableDictionary = ["title":title,"URL":url,"image":image];
            dataArray.addObject(dataDict);
            
            
            
        }
        self.dataBase.close();
        return dataArray;
    }
    func insertData(title:String , url:String , image:String) -> Void {
        
        self.dataBase.open()
        let array = NSMutableArray();
        array.addObject(title);
        array.addObject(url);
        array.addObject(image);
        self.dataBase.executeUpdate("insert into collection(title,URL,image) values(?,?,?);", withArgumentsInArray:array as [AnyObject] );
        self.dataBase.close();
    }
    func deleteData(title:String) -> Void {
        self.dataBase.open()
        if !self.dataBase.executeUpdate("delete from collection where title = (?)", withArgumentsInArray: [title]) {
            print("删除失败")
        }else
        {
            print("删除成功")
        }
        self.dataBase.close();
    }
}
