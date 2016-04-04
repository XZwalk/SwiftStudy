//
//  ShowOperationView.swift
//  QiuBai
//
//  Created by 张祥 on 16/4/5.
//  Copyright © 2016年 张祥. All rights reserved.
//

import UIKit

class ShowOperationView: UIView {

    // 创建属性
    var funnyAndCommentLabel:UILabel!
    var smileButton:UIButton!
    var cryButton:UIButton!
    var infoButton:UIButton!
    var moreButton:UIButton!
    
    let SPACE:CGFloat = 15.0
    let BUTTONSPACE:CGFloat = 50.0
    let BUTTONSIZE:CGFloat = 30.0
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        //添加所有子视图
        self.addAllViews()
        
    }
    
    //添加子视图
    func addAllViews()
    {
        //创建label
        self.funnyAndCommentLabel = UILabel(frame: CGRectMake(10, 0, UIScreen.mainScreen().bounds.size.width-20, 10));
        //self.funnyAndCommentLabel.backgroundColor = UIColor.redColor()
        self.addSubview(self.funnyAndCommentLabel)
        //创建微笑button
        
        self.smileButton = UIButton.init(type: UIButtonType.System)
        self.smileButton.frame = CGRectMake(SPACE, CGRectGetMaxY(self.funnyAndCommentLabel.frame)+SPACE, BUTTONSIZE, BUTTONSIZE)
        self.smileButton.backgroundColor = UIColor.yellowColor()
        self.addSubview(self.smileButton)
        //创建哭脸button
        self.cryButton = UIButton.init(type: UIButtonType.System)
        self.cryButton.frame = CGRectMake(CGRectGetMaxX(self.smileButton.frame)+BUTTONSPACE, CGRectGetMinY(self.smileButton.frame), BUTTONSIZE, BUTTONSIZE)
        self.cryButton.backgroundColor = UIColor.yellowColor()
        self .addSubview(self.cryButton)
        //
        self.infoButton = UIButton.init(type: UIButtonType.System)
        self.infoButton.frame = CGRectMake(CGRectGetMaxX(self.cryButton.frame)+BUTTONSPACE, CGRectGetMinY(self.cryButton.frame), BUTTONSIZE, BUTTONSIZE)
        self.infoButton.backgroundColor = UIColor.yellowColor()
        self.addSubview(self.infoButton)
        //更多按钮
        self.moreButton = UIButton.init(type: UIButtonType.System)
        self.moreButton.frame = CGRectMake(CGRectGetMaxX(self.infoButton.frame)+BUTTONSPACE, CGRectGetMinY(self.infoButton.frame), BUTTONSIZE, BUTTONSIZE)
        self.moreButton.backgroundColor = UIColor.yellowColor()
        
        self.addSubview(self.moreButton)
        
    }
    
    
    //swift的安全机制
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}