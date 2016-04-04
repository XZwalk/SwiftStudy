//
//  RootTableViewController.swift
//  QiuBai
//
//  Created by 张祥 on 16/4/5.
//  Copyright © 2016年 张祥. All rights reserved.
//

import UIKit

class RootTableViewController: UITableViewController , RefreshTableViewDelegate{

    var pageNumber:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //注册cell
        self.tableView.registerClass(HomePageTableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        //设置单例的代理
        NetworkHelper.sharedNetWork().delegate = self
        
        
        //设置上拉加载更多和下拉刷新
        self.setupRefresh()
        
        //进入程序上拉刷新
        self.tableView.header.beginRefreshing()
    }
    
    
    //实现协议的方法
    func tableViewReloadData() {
        self.tableView.reloadData()
        
        //停止刷新
        self.tableView.header.endRefreshing()
        
        self.tableView.footer.endRefreshing()
    }
    
    
    
    
    func setupRefresh() {
        
        //添加刷新方法
        self.tableView.addLegendHeaderWithRefreshingTarget(self, refreshingAction: #selector(RootTableViewController.downRefresh))
        
        self.tableView.addLegendFooterWithRefreshingTarget(self, refreshingAction: #selector(RootTableViewController.upRefresh))
        
    }
    
    
    //下拉刷新
    func downRefresh() {
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isDown")
        pageNumber = 1
        
        //调用单例的实例方法
        NetworkHelper.sharedNetWork().getDataFromServer("http://m2.qiushibaike.com/article/list/text?count=30&page=1")

    }
    
    
    
    
    //上拉加载
    func upRefresh() {
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isDown")
        
        //调用单例的实例方法
//        self.loadDataAndShow("http://m2.qiushibaike.com/article/list/text?count=30&page=\(++pageNumber)")
        
        
        NetworkHelper.sharedNetWork().getDataFromServer("http://m2.qiushibaike.com/article/list/text?count=30&page=\(pageNumber += 1)")
        
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return NetworkHelper.sharedNetWork().dataSourceArray.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HomePageTableViewCell
        
        
        //取出数据源中的模型
        let model = NetworkHelper.sharedNetWork().dataSourceArray[indexPath.row] as! NetInfoModel
        
        
        if model.iconUrl != nil {
            
            //给cell的头像赋值
            //此方法是imageView调用的
            cell.userPhoto.sd_setImageWithURL(NSURL(string: model.iconUrl as String))
        }
        
        if model.nickName != nil {
            
            //给cell的昵称赋值
            cell.nickNameLabel.text = model.nickName as String
            
        }
        
        //给cell的内容label赋值
        cell.contentLabel.text = model.content as String
        
        
        cell.showOperationView.funnyAndCommentLabel.text = "\(model.smileFace) 😊 · \(model.commentCounts) 评论"
        
        
//        cell.adjustCellSubViews(model: model)
        
        
        cell.adjustCellSubViews(use: model)
        
        //去掉cell的选中状态
        //枚举值是  枚举名.枚举内容
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    

    
    //都是相当于重写父类的方法, 所以前面都有一个override
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model:NetInfoModel = NetworkHelper.sharedNetWork().dataSourceArray[indexPath.row] as! NetInfoModel
        
        
        let changeRect:CGRect = model.content.boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width - 20, 0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(15)], context: nil)
        
        
        return 140 + changeRect.size.height
    }
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
