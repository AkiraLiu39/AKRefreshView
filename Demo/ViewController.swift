//
//  ViewController.swift
//  AKRefresh
//
//  Created by liuchang on 2016/11/30.
//  Copyright © 2016年 com.unknown. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    public enum SimpleType:Int{
        case simpleHeader = 0,floatHeader,simpleFooter,autoFooter,floatFooter
    }
    @IBOutlet weak var tableViewOutlet: UITableView!
    var type:SimpleType!
    var items = [String]()
    private let cellId = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRefreshView()
        self.navigationController?.navigationBar.isTranslucent = true
//        self.tableViewOutlet.akr.startHeaderAction()
    }

    private func setupRefreshView(){
        switch type! {
        case .simpleHeader:
            self.tableViewOutlet.akr.header = SimpleHeader(action: { [weak self] in
                self?.appendData()
            })
            break
        case .floatHeader:
            self.tableViewOutlet.akr.header = FloatHeader(action: {[weak self] in
                self?.appendData()
            })
            break

        case .simpleFooter:
            (0...2).forEach{
                self.items.append("base \($0)")
            }
            self.tableViewOutlet.akr.footer = SimpleFooter(action: {[weak self] in
                self?.appendData()
            })
            break
        case .autoFooter:
            (0...2).forEach{
                self.items.append("base \($0)")
            }
            self.tableViewOutlet.akr.footer = AutoFooter(action: {[weak self] in
                self?.appendData()
            })
            break
        case .floatFooter:
            (0...2).forEach{
                self.items.append("base \($0)")
            }
            self.tableViewOutlet.akr.footer = FloatFooter(action: {[weak self] in
                self?.appendData()
            })
            break
        }

    }

    
    func appendData() {
        let time = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: time, execute: {[weak self] in
            if let count = self?.items.count{
                (count ... count + 5).forEach {self?.items.append("item \($0)")}
            }
            self?.tableViewOutlet.reloadData()
            if let footer = (self?.tableViewOutlet.akr.footer) as? AKRefreshAutoFooter{
                footer.autoTriggerEnable = !((self?.items.count ?? 0) > 25)
            }
            self?.tableViewOutlet.akr.endHeaderAction()
            if let footer = (self?.tableViewOutlet.akr.footer) as? AKRefreshFloatFooter{
                footer.endRefreshAfterMessage("oh~~", duration: 2)
            }else{
                self?.tableViewOutlet.akr.endFooterAction()
            }
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        cell?.textLabel?.text = items[indexPath.row]
        cell?.backgroundColor = UIColor.red
        return cell!
    }

    deinit {
        print("memo safe")
    }

}

