//
//  LGFCreateLabelViewController.swift
//  LittleLabel
//
//  Created by peterlee on 2019/3/20.
//  Copyright © 2019 Personal. All rights reserved.
//创建标签的页面

import UIKit

class LGFCreateLabelViewController: LGFBaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView!
    
    var alertView:UIAlertController!
    
    var dataArray:[String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "创建标签"
        // Do any additional setup after loading the view.
    }
    
    override func addSubviews() {
        tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.frame = self.view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 35
        self.view.addSubview(tableView)
        let footerView = UIButton(type: UIButton.ButtonType.contactAdd)
        tableView.tableFooterView = footerView
        footerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60)
        footerView.addTarget(self, action: #selector(addButtonClick), for: UIControl.Event.touchUpInside)
    }
    
    
    //MARK:UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard dataArray != nil else {
            return 0
        }
        return dataArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard  dataArray != nil else {
            return cell
        }
        cell.textLabel?.text = dataArray![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(LGFAnimationViewController(), animated: true)
    }

    @objc private func addButtonClick()
    {
        
        alertView = UIAlertController.init(title: "添加一个新标签", message: nil, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        let addAction = UIAlertAction.init(title: "确定", style: .default) {[weak self](action) in
            let textField = self!.alertView.textFields?.first
            
            if textField?.text?.count == 0
            {
                return
            }
            else
            {
                self?.dataArray?.append((textField?.text)!)
                self?.tableView.reloadData()
            }
        }
        alertView.addAction(action)
        alertView.addAction(addAction)
        alertView.addTextField { (textField) in
            textField.placeholder = "请输入新的标签"
        }
        
        self.present(alertView, animated: true, completion: nil)
    }
    
}
