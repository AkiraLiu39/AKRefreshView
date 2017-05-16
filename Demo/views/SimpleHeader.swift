//
//  SimpleHeader.swift
//  AKRefresh
//
//  Created by liuchang on 2016/12/1.
//  Copyright © 2016年 com.unknown. All rights reserved.
//

import UIKit

class SimpleHeader: AKRefreshHeader {
    weak var textLabel:UILabel!
    override init(
        height: CGFloat = DEFAULT_HEIGHT,
        indicator: AKRefreshIndicator = CircleIndicator(),
        action:@escaping (()->())
        ){
        super.init(height:height,indicator:indicator,action:action)
        let label = UILabel()
        label.text = "敢不敢再往下拉一点!?";
        label.font = UIFont.systemFont(ofSize: 14);
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center;
        self.addSubview(label)
        self.textLabel = label;
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func refreshViewChangeUIWhenNormal(_ refreshView: AKRefreshViewType) {
        super.refreshViewChangeUIWhenNormal(refreshView)
        self.textLabel.text = "敢不敢再往下拉一点!?"
    }
    override func refreshViewChangeUIWhenWillLoading(_ refreshView: AKRefreshViewType) {
        super.refreshViewChangeUIWhenWillLoading(refreshView)
        self.textLabel.text = "使劲！"
    }
    override func refreshViewChangeUIWhenLoading(_ refreshView: AKRefreshViewType) {
        super.refreshViewChangeUIWhenLoading(refreshView)
        self.textLabel.text = "loading..."
    }

    override func refreshViewChangeUIWhenFinish(_ refreshView: AKRefreshViewType) {
        super.refreshViewChangeUIWhenFinish(refreshView)
        self.textLabel.text = "finish"
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let paddingY:CGFloat = 5.0;
        let loadingViewWH :CGFloat  = 30.0;
        let loadingViewX  :CGFloat = (self.frame.width - loadingViewWH) / 2;
        let loadingViewY :CGFloat  = paddingY;
        let loadingViewFrame = CGRect(x:loadingViewX, y:loadingViewY, width:loadingViewWH, height:loadingViewWH);
        self.indicator?.frame = loadingViewFrame;

        let labelX:CGFloat = 0;
        let labelY:CGFloat = loadingViewFrame.maxY + paddingY;
        let labelW:CGFloat = self.frame.width;
        let labelH:CGFloat = self.frame.height - labelY;
        self.textLabel.frame = CGRect(x:labelX, y:labelY, width:labelW, height:labelH);
    }
}
