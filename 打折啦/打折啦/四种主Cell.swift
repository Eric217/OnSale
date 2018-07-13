//
//  ELCollectionViewCell.swift
//  打折啦
//
//  Created by Eris on 2017/8/18.
//  Copyright © 2017年 INGStudio. All rights reserved.
//

import Foundation
import Alamofire
///MARK: - 第一个cell
class ELPersonViewCell: UICollectionViewCell {

    var gradient: CAGradientLayer!
    var collect: DoubleDecker!
    var care: DoubleDecker!
    var hist: DoubleDecker!
    var personView: PersonSelfView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gradient = CAGradientLayer()
        setupGradient(gradient)
        setGradientColor(Config.themeColor)
        var f = myRect(0, bounds.height-2*SmallItemHeight, ScreenWidth/3, SmallItemHeight*2)
        collect = DoubleDecker(frame: f)
        collect.tag = 300
        f.origin.x = ScreenWidth/3
        care = DoubleDecker(frame: f)
        care.tag = 301
        f.origin.x = 2*ScreenWidth/3
        hist = DoubleDecker(frame: f)
        collect.setNum(0, title: "我的收藏")
        care.setNum(0, title: "关注")
        hist.setNum(0, title: "我的足迹")
        hist.tag = 302
        addSubview(collect)
        addSubview(care)
        addSubview(hist)
        
        personView = PersonSelfView()
        addSubview(personView)
        personView.snp.makeConstraints{ make in
            make.left.equalTo(0)
            make.bottom.equalTo(collect.snp.top).offset(-8)
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(82)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func fillContents(_ content: Any?) {
        Alamofire.request(Router.getFavorOrHist(0, 1, 1)).validate().responseJSON {
            response in
            switch response.result {
            case .success(let v):
                let js = JSON(v)
                self.collect.setNum(js["data"]["total"].int)
            default: break
            }
        }
        Alamofire.request(Router.getFavorOrHist(1, 1, 1)).validate().responseJSON {
            response in
            switch response.result {
            case .success(let v):
                let js = JSON(v)
                self.hist.setNum(js["data"]["total"].int)
            default: break
            }
        }
        personView.fillContents(content)

    }
    
    func setGradientColor(_ color: UIColor, _ by: CGFloat = 0.55) {
        gradient.colors = [color.cgColor, color.getWhiter(by: by).cgColor]
    }
    
    func didTap(_ sender: UITapGestureRecognizer) {
        print(123323)
    }
    
}

///MARK: - 第2个cell

class ELUploadViewCell: UICollectionViewCell {
    
    var desc: RightLabelCell!
    var empty: EmptyUploadView?
    var uploaded1: UploadedView?
    var uploaded2: UploadedView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        desc = RightLabelCell()
        desc.backgroundColor = UIColor.white
        addSubview(desc)
        desc.snp.makeConstraints{ m in
            m.top.left.equalTo(0)
            m.width.equalTo(ScreenWidth)
            m.height.equalTo(titleHeight)
        }
        desc.setLeftText("我的发布", color: UIColor.black)
        desc.setRightText("查看全部发布", size: 13, color: .lightGray)
        
        
        
        
        
        
        
        desc.addBottomLine(color: UIColor.lightGray.withAlphaComponent(0.42))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func fillContents(_ content: Any?) {
        
    }
    
}


///MARK: - 第3个cell

class ELToolViewCell: UICollectionViewCell {
    
    var desc: RightLabelCell!
    var collect: UICollectionView!
    
    let dataArr = ["我的发布", "我的评价", "我的圈子"
        , "我的小蜜", "更换皮肤", "游戏中心", "记账本", "我的信用", "必备工具", "查看全部工具"]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        desc = RightLabelCell()
        desc.backgroundColor = UIColor.white
        addSubview(desc)
        desc.snp.makeConstraints{ m in
            m.top.left.equalTo(0)
            m.width.equalTo(ScreenWidth)
            m.height.equalTo(titleHeight)
        }
        desc.setLeftText(dataArr[8], color: UIColor.black)
        desc.setRightText(dataArr[9], size: 13, color: .lightGray)
        
      
        let itemH = itemHeight-titleHeight
        let lay = ELCollectionViewFlowLayout()
        lay.itemSize = CGSize(width: ScreenWidth/4, height: itemH/2)
        lay.minimumLineSpacing = 0.5
        lay.minimumInteritemSpacing = 0
        collect = UICollectionView(frame: myRect(0, titleHeight, ScreenWidth, itemH), collectionViewLayout: lay)
        collect.backgroundColor = UIColor.groupTableViewBackground
        collect.register(DoubleDeckerCell.self, forCellWithReuseIdentifier: Identifier.doubledeckerId)
        addSubview(collect)
        collect.isScrollEnabled = false
        desc.addBottomLine(color: UIColor.lightGray.withAlphaComponent(0.42))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
}

///MARK: - 卡片cell


class ELCardViewCell: UICollectionViewCell {
    var card: Card!
    
    
    
    override func fillContents(_ content: Any?) {
        
    }
}










