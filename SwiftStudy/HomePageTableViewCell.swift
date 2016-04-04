//
//  HomePageTableViewCell.swift
//  QiuBai
//
//  Created by 张祥 on 16/4/5.
//  Copyright © 2016年 张祥. All rights reserved.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {

    //创建属性

    var userPhoto:UIImageView!
    var nickNameLabel:UILabel!
    var contentLabel:UILabel!
    var showOperationView:ShowOperationView!
    
    
    //间距
    let spaceWH:CGFloat = 10.0
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        //调用添加子视图方法
        self.addAllViews()
        
        
    }
    
    //这是我们swift中的安全机制, 我们重写父类的构造方法的时候, 需要一个构造方法参数为 aDecoder: NSCoder
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    func addAllViews() {
        
        
        self.userPhoto = UIImageView(frame: CGRectMake(spaceWH, spaceWH, 40, 40))
        self.userPhoto.backgroundColor = UIColor.orangeColor()
        
        //打开交互, 打不打开都行
        self.userPhoto.userInteractionEnabled = true
        //设置圆角
        self.userPhoto.layer.cornerRadius = 20
        self.userPhoto.layer.masksToBounds = true
        self.addSubview(self.userPhoto)
        
        
        
        self.nickNameLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(self.userPhoto.frame) + spaceWH, spaceWH, UIScreen.mainScreen().bounds.size.width - 70, 40))
        //self.nickNameLabel.backgroundColor = UIColor.orangeColor()
        self.addSubview(self.nickNameLabel)
        
        
        
        
        
        self.contentLabel = UILabel(frame: CGRectMake(spaceWH, CGRectGetMaxY(self.nickNameLabel.frame) + spaceWH, UIScreen.mainScreen().bounds.size.width - 20, 80))
        //self.contentLabel.backgroundColor = UIColor.yellowColor()
        self.contentLabel.font = UIFont.systemFontOfSize(15)
        self.contentLabel.numberOfLines = 0
        self.addSubview(self.contentLabel)
        
        
        
        
        
        self.showOperationView = ShowOperationView(frame: CGRectMake(0, CGRectGetMaxY(self.contentLabel.frame) + 10, UIScreen.mainScreen().bounds.size.width, 70))
        self.addSubview(self.showOperationView)
        
        
        
        
        
    }
    
    
    
    //根据label的内容, 从新布局cell
    //#外部参数, 在外面也能访问到
    func adjustCellSubViews(use model:NetInfoModel) {
        
        let changeRect:CGRect = model.content.boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width - 20, 0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(15)], context: nil)
        
        //先接收一下label的frame, 因为label的frame不能直接改变
        var frame:CGRect = self.contentLabel.frame
        
        //修改frame的高, 根据字体的高度
        frame.size.height = changeRect.size.height
        
        //修改label的frame
        self.contentLabel.frame = frame
        
        //更新label下面的控件的frame
        self.showOperationView.frame = CGRectMake(0, CGRectGetMaxY(self.contentLabel.frame) + 10, UIScreen.mainScreen().bounds.size.width, 70)
        
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
