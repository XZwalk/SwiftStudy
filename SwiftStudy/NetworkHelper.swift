//
//  NetworkHelper.swift
//  QiuBai
//
//  Created by 张祥 on 16/4/5.
//  Copyright © 2016年 张祥. All rights reserved.
//

import UIKit

//协议
protocol RefreshTableViewDelegate:NSObjectProtocol
{
    func tableViewReloadData()
}



class NetworkHelper: NSObject {
    
    
    var dataSourceArray:NSMutableArray = NSMutableArray()
    
    
    var delegate:RefreshTableViewDelegate!
    
    
    
    //类方法
    //只有结构体的类方法才有static
    class func sharedNetWork()->NetworkHelper {
    
        
        
        struct NetWorkSTR {
            static var netWorkHelper:NetworkHelper?
            
            //typealias 和c语言中的typ重命名一样
            //dispatch_once也是下面线程里面的一个参数
            static var dispatch_once:dispatch_once_t = 0
        }
        
        //创建单例, 闭包里面的代码只执行一次
        dispatch_once(&NetWorkSTR.dispatch_once, { () -> Void in
            NetWorkSTR.netWorkHelper = NetworkHelper()
            
        })
        return NetWorkSTR.netWorkHelper!
    }
    
    
    
    
    
    func getDataFromServer(urlStr:NSString) {
        
        //NSURL(  返回一个可选类型, 需要进行强制解析(加!)
        let url:NSURL = NSURL(string: urlStr as String)!
        
        let urlRequest:NSURLRequest = NSURLRequest(URL: url)
        
        //(response:NSURLResponse!, data:NSData!, error:NSError!) 自己写参数, 后面使用的时候还没提示, 得自己敲出来
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse?, data:NSData?, error:NSError?) -> Void in
            
            if data != nil {
                
                //判断如果是下拉刷新就清除数据
                if NSUserDefaults.standardUserDefaults().boolForKey("isDown") == true {
                    
                    self.dataSourceArray.removeAllObjects()
                }
                
                
                
                
                do{
                    
                    let dic: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                    let itemsArray = dic["items"] as! NSArray
                    for modelDic in itemsArray {
                        
                        let aDic = modelDic as! NSDictionary
                        
                        let model:NetInfoModel = NetInfoModel(dic: aDic)
                        
                        self.dataSourceArray.addObject(model)
                    }
                    
                    
                    
                    
                    
                    
                    //如果代理不为空
                    if self.delegate != nil {
                        
                        //如果代理响应这个方法
                        if self.delegate.respondsToSelector("tableViewReloadData") {
                            
                            //让代理执行协议方法
                            self.delegate.tableViewReloadData()
                            
                        }
                        
                    }
                
                    
                }catch{
                    print("error")
                }
                
                
                
                
                
            }
            
        }
    

    }
    
 }
