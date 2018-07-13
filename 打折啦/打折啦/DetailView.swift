//
//  DetailView.swift
//  打折啦
//
//  Created by Eric on 11/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation

extension DetailController: ScrollSizeDidChangeDelegate {
    
    func setupWholeScroll() {
    //
        scroll = UIScrollView(frame: myRect(0, 64, ScreenWidth, ScreenHeight-64-44))
        scroll.contentSize = mySize(ScreenWidth, 1)
        scroll.alwaysBounceVertical = true
        view.addSubview(scroll)
        scroll.delegate = self
        scroll.backgroundColor = UIColor.white
    
        setupHeadAndDesc()
        setupCollection()
        
    }
    
    func updateScrollHeight(_ delta: CGFloat) {
        scroll.contentSize.height += delta
    }
    
    func setupHeadAndDesc() {
        let fontsize: CGFloat = 18
        let topInset: CGFloat = 18
    //
        personView = ELPersonCell2(frame: myRect(left, topInset, ScreenWidth-2*left, 44))
        partHight += 44
        scroll.addSubview(personView)
        personView.fillContents(item)
        descLabel = AttributedLabel()
        scroll.addSubview(descLabel)
        
        let l = item.threeLevel!
        let position = l[0]+l[1]+l[2]+" "+item.location
        let desc = item.title + " " + (item.description == "" ? "感兴趣的话给我留言吧！" : item.description)!
        let txt = desc + "\n详细地址: " + position
        descLabel.snp.makeConstraints { make in
            make.left.width.equalTo(personView)
            make.top.equalTo(personView.snp.bottom).offset(topInset)
            make.height.equalTo(20)
        }
        let incre = descLabel.setAutoHeightText(txt, fontSize: fontsize, max: mySize(ScreenWidth-2*left, ScreenHeight))
        updateScrollHeight(44+incre+2*topInset-1)
        partHight += incre + 2*topInset
    }
    
    func setupBars() {
        view.backgroundColor = UIColor.groupTableViewBackground
        fd_prefersNavigationBarHidden = true
        navBar = ELBackNavigationBar()
        navBar.setBackColor(Config.themeColor)
        navBar.setupTitle("商品详情")
        navBar.setRightImage("more")
        navBar.backButton.txt.text = ""
        let share = UIButton()
        share.addTarget(self, action: #selector(shareTo), for: .touchUpInside)
        navBar.addSubview(share)
        share.imageView?.contentMode = .scaleAspectFit
        share.setBackgroundImage(#imageLiteral(resourceName: "share"), for: .normal)
        share.snp.makeConstraints{ make in
            make.right.equalTo(navBar.rightButton.snp.left).offset(-15)
            make.height.centerY.equalTo(navBar.rightButton)
            make.width.equalTo(25)
        }
        view.addSubview(navBar)
        navBar.backButton.addTapGest(target: self, action: #selector(back))
        navBar.rightButton.addTapGest(target: self, action: #selector(more))
        
        tool = ELToolBar(frame: myRect(0, ScreenHeight-44, ScreenWidth, 44))
        tool.button1.addTapGest(target: self, action: #selector(leaveMsg))
        tool.button2.addTapGest(target: self, action: #selector(collect))
        tool.button3.addTapGest(target: self, action: #selector(talk))
        tool.button4.addTarget(self, action: #selector(goThere), for: .touchUpInside)

        view.addSubview(tool)
    
    }
    
    func setupComment() {
        commControl = CommentController()
        commControl.itemId = item.id
        commControl.initial(item.id, upId: item.user.id, dele: self)
        addChildViewController(commControl)
        scroll.addSubview(commControl.view)
        commControl.view.snp.makeConstraints { make in
            make.top.equalTo(vie.snp.bottom)
            make.height.equalTo(46)
            make.width.equalTo(ScreenWidth)
            make.left.equalTo(0)
        }
    }
    
    func change(by: CGFloat) {
        updateScrollHeight(by)
    }
    
    func addFooter(_ footer: MJRefreshAutoNormalFooter) {
        scroll.mj_footer = footer
    }
    
    func loadLike(_ withData: Bool) {
        if !withData {
            v = AttributedLabel()
            v.backgroundColor = UIColor.groupTableViewBackground
            scroll.addSubview(v)
            v.snp.makeConstraints { make in
                make.left.equalTo(0)
                make.top.equalTo(commControl.view.snp.bottom)
                make.width.equalTo(ScreenWidth)
                make.height.equalTo(25)
            }
            v.text = "--- 猜你喜欢 ---"
            v.contentAlignment = .center
            v.textColor = UIColor.gray
            v.font = UIFont.systemFont(ofSize: 12)
            updateScrollHeight(25)
        }
        
        likeControl = LikeController()
        likeControl.initial(loca: item.threeLevel, type: item.type, dele: self)
        addChildViewController(likeControl)
        scroll.addSubview(likeControl.view)
        likeControl.view.snp.makeConstraints { make in
            make.left.equalTo(0)
            if v == nil {
                make.top.equalTo(commControl.view.snp.bottom)
            }else {
                make.top.equalTo(v.snp.bottom)
            }
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(50)
        }
    }
    
    func setupCollection() {
        
        // "a".components(separatedBy: "|") = ["a"], "a|" -> ["a", ""]
        let picRatios = item.picRatio.components(separatedBy: "|")
        var hei: CGFloat = 0
        heightArr = [CGFloat]()
        //值是长比宽，知道长，则(高) = 长／值
        for i in 0..<picRatios.count {
            let v = ceil(picWidth/CGFloat(NSString(string: picRatios[i]).floatValue))
            heightArr.append(v)
            hei += v + seperatorH
        }
        hei -= seperatorH
        //hei的值为 图片高度+间隔线高度,没有上下inset
        
        let lay = UICollectionViewFlowLayout()
        lay.minimumInteritemSpacing = seperatorH
        collection = UICollectionView(frame: CGRect(), collectionViewLayout: lay)
        collection.backgroundColor = UIColor.white
        collection.isScrollEnabled = false
        scroll.addSubview(collection)
        collection.delegate = self
        collection.dataSource = self
        collection.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: Identifier.imgCellId)
        collection.snp.makeConstraints { make in
            make.left.equalTo(left)
            make.width.equalTo(picWidth)
            make.height.equalTo(hei)
            make.top.equalTo(descLabel.snp.bottom).offset(10)
            
        }
        partHight += hei
        vie = UIView()
        vie.backgroundColor = UIColor.groupTableViewBackground
        scroll.addSubview(vie)
        vie.snp.makeConstraints { make in
            make.left.width.equalTo(scroll)
            make.height.equalTo(13)
            make.top.equalTo(collection.snp.bottom).offset(10)
            
        }
        updateScrollHeight(hei+33)
        
        
    }
    
}






