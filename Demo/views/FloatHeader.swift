//
//  FloatHeader.swift
//  AKRefresh
//
//  Created by liuchang on 2016/12/2.
//  Copyright © 2016年 com.unknown. All rights reserved.
//

import UIKit

class FloatHeader: AKRefreshFloatHeader {
    weak var textLabel:UILabel!
    private var lastRefreshDate:Date?
    private var dateFormaterRef = [String:DateFormatter]()
    override init(
        height: CGFloat = DEFAULT_HEIGHT,
        indicator: AKRefreshIndicator = CircleIndicator(),
        action:@escaping (()->())
        ){
        super.init(height:height,indicator:indicator,action:action)
        let label = UILabel()
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

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        if keyPath == AKRefreshView.KVOPath.scrollViewContentOffsetPath.rawValue
            && self.progress >= 0.5{
            self.adjustLabelText()
        }
    }
    private func adjustLabelText(){
        if let lastRefresh = self.lastRefreshDate{
            let calendar = Calendar.current

            let unit:Set = [Calendar.Component.year, .month,.day,.hour,.minute,.second]
            let components = calendar.dateComponents(unit, from: lastRefresh,to:Date())
            if components.year ?? 0 > 0 {
                self.textLabel.text = "呵呵"
            }else if components.month ?? 0 > 0{
                self.textLabel.text = "\(self.formatDate(lastRefresh, format: "yyyy-MM")) 刷新"
            }else if components.day ?? 0 > 0{
                self.textLabel.text = "\(self.formatDate(lastRefresh, format: "yyyy-MM-dd")) 刷新"
            }else if components.hour ?? 0 > 0 {
                self.textLabel.text = "\(String(describing: components.hour))小时前刷新刷新"
            }else if components.minute ?? 0 > 0{
                self.textLabel.text = "\(String(describing: components.minute))分钟前刷新"
            }else{
                self.textLabel.text = "刚刚刷新"
            }
        }
    }
    private func formatDate(_ date:Date,format:String) -> String{
        if let formatter = self.dateFormaterRef[format]{
            return formatter.string(from: date)
        }else{
            let formatter = DateFormatter()
            formatter.dateFormat = format
            self.dateFormaterRef[format] = formatter
            return formatter.string(from: date)
        }
    }

    override func refreshViewChangeUIWhenFinish(_ refreshView: AKRefreshViewType) {
        super.refreshViewChangeUIWhenFinish(refreshView)
        self.lastRefreshDate = Date()
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
