//
//  SimpleFooter.swift
//  AKRefresh
//
//  Created by liuchang on 2016/12/2.
//  Copyright © 2016年 com.unknown. All rights reserved.
//

import UIKit

class SimpleFooter: AKRefreshFooter {

    override init(height: CGFloat = DEFAULT_HEIGHT, indicator: AKRefreshIndicator = CircleIndicator(), action: @escaping (() -> ())) {
        super.init(indicator: indicator, action: action)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let indicatorWH:CGFloat = 30
        let centerX = (self.frame.width - indicatorWH) / 2
        let centerY = (self.frame.height - indicatorWH) / 2
        let indicatorFrame = CGRect(x: centerX, y: centerY, width: indicatorWH, height: indicatorWH)
        self.indicator?.frame = indicatorFrame
    }

}
