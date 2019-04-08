//
//  LGFCollcetionView.swift
//  LittleLabel
//
//  Created by peterlee on 2019/3/20.
//  Copyright © 2019 Personal. All rights reserved.
//

import UIKit

class LGFCollcetionView: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let cellIdentifier = "LGFCollcetionViewCell"
    let headerIdentifier = "LGFCollcetionViewHeaderView"
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame:CGRect)
    {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: (self.frame.width - 8)/7.0, height: 200)
        layout.headerReferenceSize = CGSize(width: self.frame.width, height: 44)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        self.backgroundColor = UIColor.white
        self.delegate = self
        self.dataSource = self
        self.register(LGFCollectionCell.classForCoder(), forCellWithReuseIdentifier: cellIdentifier)
        self.register(LGFHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
    
    
    //MARK:UICollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:LGFCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LGFCollectionCell
        cell.backgroundColor = UIColor.gray
        var datesArray = ["get up","sleep","listen","reading","relax","exersice","swiming"]
        cell.datesArray = datesArray
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath)
        headerView.backgroundColor = UIColor.white
        return headerView
    }

}

class LGFHeaderView: UICollectionReusableView {
    
    let datesArray = ["星期一","星期二","星期三","星期四","星期五","星期六","星期日"]

    override init(frame: CGRect) {
        super.init(frame: frame)
       setupData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupData()
    {
        for view in self.subviews
        {
            view.removeFromSuperview()
        }
        guard datesArray.count == 0 else {
            let width = self.frame.width/CGFloat(datesArray.count)
            let heigh = self.frame.height
            for date in datesArray
            {
                let label = UILabel()
                label.text = date
                label.font = UIFont.systemFont(ofSize: 10)
                label.textAlignment = .center
                label.textColor = UIColor.lightGray
                let index = datesArray.firstIndex(of: date)
                label.frame = CGRect(x: CGFloat(index!) * width, y: 0, width: width, height: heigh)
                addSubview(label)
            }
            return
        }
    }
    
    
}



class LGFCollectionCell: UICollectionViewCell {
    var datesArray = ["星期一","星期二","星期三","星期四","星期五","星期六","星期日"]
    {
        didSet{
            setupData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupData()
    {
            for view in self.subviews
            {
                view.removeFromSuperview()
            }
        
        guard datesArray.count == 0 else {
            let width = self.frame.width
            let heigh = self.frame.height/7
            for date in datesArray
            {
                let label = UILabel()
                label.text = date
                label.font = UIFont.systemFont(ofSize: 10)
                label.textAlignment = .center
                label.textColor = UIColor.lightGray
                let index = datesArray.firstIndex(of: date)
                label.frame = CGRect(x: 0, y: heigh*CGFloat(index!), width: width, height: heigh)
                addSubview(label)
            }
            return
        }
    }
}
