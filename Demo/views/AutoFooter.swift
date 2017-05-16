//
//  AutoFooter.swift
//  AKRefresh
//
//  Created by liuchang on 2016/12/2.
//  Copyright © 2016年 com.unknown. All rights reserved.
//

import UIKit

class AutoFooter: AKRefreshAutoFooter {

    override init(height: CGFloat = DEFAULT_HEIGHT, indicator: AKRefreshIndicator = CircleIndicator(), action: @escaping (() -> ())) {
        super.init(height: height, indicator: indicator, action: action)
        self.actionButton?.setTitle("没有更多数据了...", for: .disabled)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let loadingViewWH:CGFloat = 30;
        let centerX = (self.frame.width - loadingViewWH) / 2 ;
        let centerY = (self.frame.height - loadingViewWH) / 2;
        let loadingViewFrame = CGRect(x:centerX, y:centerY, width:loadingViewWH, height:loadingViewWH);
        self.indicator?.frame = loadingViewFrame;
    }

}
