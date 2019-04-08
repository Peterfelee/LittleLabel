//
//  LGFViewController.swift
//  LittleLabel
//
//  Created by peterlee on 2019/3/20.
//  Copyright © 2019 Personal. All rights reserved.
//

import UIKit

class LGFViewController: LGFBaseViewController {
    
    private var collectionView:LGFCollcetionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的标签"
        setupNavgationBar()
        // Do any additional setup after loading the view.
    }
    
    
    override func addSubviews() {
        collectionView = LGFCollcetionView(frame: self.view.bounds)
        view.addSubview(collectionView!)
    }
    
    
    
    
    
    
    @objc func leftButtonClick()
    {
        self.navigationController?.pushViewController(LGFEffectionAnaysisViewController(), animated: true)
    }
    
    @objc func rightButtonClick()
    {
        self.navigationController?.pushViewController(LGFCreateLabelViewController(), animated: true)
    }
    
    private func setupNavgationBar()
    {
        let leftButton = UIButton.init(type: .contactAdd)
        leftButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        leftButton.addTarget(self, action: #selector(LGFViewController.leftButtonClick), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton)
        
        let rightButton = UIButton.init(type: .contactAdd)
        rightButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        rightButton.addTarget(self, action: #selector(LGFViewController.rightButtonClick), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton)
    }
    
    
}

