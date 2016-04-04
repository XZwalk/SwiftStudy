//
//  NetInfoModel.swift
//  QiuBai
//
//  Created by 张祥 on 16/4/5.
//  Copyright © 2016年 张祥. All rights reserved.
//

import UIKit

class NetInfoModel: NSObject {
   
    
    var iconUrl:NSString!
    var nickName:NSString!
    var content:NSString!
    var smileFace:NSNumber!
    var commentCounts:NSNumber!
    
    
    
    init(dic:NSDictionary) {
        
        //dic["content"]返回NSObject, 转为NSString类型
        self.content = dic["content"] as! NSString
        self.commentCounts = dic["comments_count"] as! NSNumber
        
        
        let votesDic = dic["votes"] as! NSDictionary
        self.smileFace = votesDic["up"] as! NSNumber
        
        
        //如果user字典存在, 再写代码
        if dic["user"] is NSDictionary {
            let userDic = dic["user"] as! NSDictionary
            self.nickName = userDic["login"] as! NSString
            
            
            
            //图片数据较坑爹, 有的事NSString类型, 有是NSNumber类型, 有的是nil
            if userDic["icon"] is NSString {
                
                if userDic["id"] is NSString {
                    
                    //找到id
                    let idStr:NSString = userDic["id"] as! NSString
                    
                    //截取前4位  :NSString 可以省略, 系统自动识别
                    let idStr4 = idStr.substringToIndex(4) as NSString
                    
                    //找到iconStr
                    let iconStr:NSString = userDic["icon"] as! NSString
                    
                    //拼接字符串, 也就是我们的头像网址
                    self.iconUrl = kPhotoUrl + "\(idStr4)/\(idStr)/medium/\(iconStr)"
                    
                }else {
                    
                    let idNumber:NSNumber = userDic["id"] as! NSNumber
                    let idStr = "\(idNumber)" as NSString
                    
                    //截取前4位  :NSString 可以省略, 系统自动识别
                    let idStr4 = idStr.substringToIndex(4) as NSString
                    
                    //找到iconStr
                    let iconStr:NSString = userDic["icon"] as! NSString
                    
                    //拼接字符串, 也就是我们的头像网址
                    self.iconUrl = kPhotoUrl + "\(idStr4)/\(idStr)/medium/\(iconStr)"
                    
                }
                
                
            }else {
                
                
                self.iconUrl = nil;
                
            }
            
            
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    //http://pic.qiushibaike.com/system/avtnew/
    
    //kUserAvatarFormat + "\(idStrAdvance4)/\(idStr1)/medium/\(iconURL)
    
    
    
    
    
    
    
    
    
    
}
