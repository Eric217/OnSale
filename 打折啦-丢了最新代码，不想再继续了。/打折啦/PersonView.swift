//
//  PersonOverview.swift
//  打折啦
//
//  Created by Eris on 2017/8/16.
//  Copyright © 2017年 INGStudio. All rights reserved.
//

import Foundation

let cell0Height: CGFloat = 80
let refreshHeight: CGFloat = 54
var refreshPlus: CGFloat = 36

/* 关于tag：
 200 : refreshHeader
 298,299 : tool-childCollectionView
 300,301,302 : collected,cared,history
 
 
 */
extension PersonViewController {
    
    
    func setupCollectionView() {
        view.backgroundColor = .white
        let lay = UICollectionViewFlowLayout()
        lay.minimumLineSpacing = 14
        collection = UICollectionView(frame: myRect(0, -20, ScreenWidth, 20+ScreenHeight), collectionViewLayout: lay)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = myColor(240, 240, 240)
        
        collection.register(ELCardViewCell.self, forCellWithReuseIdentifier: Identifier.cardCellId)
        collection.register(ELPersonViewCell.self, forCellWithReuseIdentifier: Identifier.meCellId)
        collection.register(ELToolViewCell.self, forCellWithReuseIdentifier: Identifier.toolCellId)
        collection.register(ELUploadViewCell.self, forCellWithReuseIdentifier: Identifier.upCellId)
        view.addSubview(collection)

        collection.mj_header = refreshHeader
        //collection.showsVerticalScrollIndicator = false

        customRefresh()
        addBottomButton()

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        tap.delegate = self
        collection.addGestureRecognizer(tap)
    }
    
    func addBottomButton() {
        addCard = AddCardButton()
        addCard.setColor(Config.themeColor)
        collection.addSubview(addCard)
        addCard.snp.makeConstraints{ make in
            make.centerX.equalTo(collection)
            make.width.equalTo(66)
            make.height.equalTo(95)
            make.bottom.equalTo(collection).inset(50)
        }
    }
    
    func customRefresh() {
        
        let l = CAGradientLayer()
        l.zPosition = -1
        refreshHeader.setupGradient(l)
        refreshHeader.layer.backgroundColor = UIColor.clear.cgColor
        let fill = UIView(frame: myRect(0, -refreshPlus, ScreenWidth, refreshPlus))
        fill.tag = 200
        fill.setupGradient()
        refreshHeader.addSubview(fill)
        refreshHeader.setGradientWith(subView: 200, Config.themeColor, by: 0.55)
    }
    
    func setupBar() {
        
        navBar = ELMeNavigationBar()
        fd_prefersNavigationBarHidden = true
        view.addSubview(navBar)
        navBar.setBackColor(Config.themeColor, by: 0.55)
        navBar.setDefault(title: "设置", img: "code")
        navBar.codeButton.addTarget(self, action: #selector(scan), for: .touchUpInside)
        navBar.setButton!.addTarget(self, action: #selector(setting), for: .touchUpInside)
    }
    
}






//flow layout 协议没有实现，这里没必要
extension PersonViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell {
        let row = indexPath.item
    
        if collectionView.tag == 299 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.doubledeckerId, for: indexPath) as! DoubleDeckerCell
            cell.setTxt(dataArr[row])
            cell.setImg_("tool\(row)")
            return cell
        }
        
        if row >= 3 {
            let cell = collection.dequeueReusableCell(withReuseIdentifier: Identifier.cardCellId, for: indexPath) as! ELCardViewCell
            cell.fillContents(person)
            
            return cell
        }
        
        if row == 0 {
            print("cell for row at--------")
            let cell = collection.dequeueReusableCell(withReuseIdentifier: Identifier.meCellId, for: indexPath) as! ELPersonViewCell
            cell.fillContents(person)
        
            return cell
        }
        
        if row == 1 {
            let cell = collection.dequeueReusableCell(withReuseIdentifier: Identifier.upCellId, for: indexPath) as! ELUploadViewCell
            cell.fillContents(person)
            return cell
        }
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: Identifier.toolCellId, for: indexPath) as! ELToolViewCell
        if cell.collect.tag != 299 {
            cell.collect.tag = 299
            cell.collect.dataSource = self
            cell.collect.delegate = self
        }
        return cell

    }
    
   
    //------------------
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let row = indexPath.item
        if collectionView.tag == 299 {
            print(hh+hh+hh)
            pushWithoutTab(MoreViewController()); return
        }
        if row == 1 {
            
        }else if row == 2 {
            print(hh+hh+hh)
        }
    
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        if collectionView.tag == 299 {
            return CGSize(width: ScreenWidth/4, height: itemHeight/2-titleHeight/2)

        }else
        if indexPath.item == 0 {
            return CGSize(width: ScreenWidth, height: cell0Height+2*SmallItemHeight+64)
        }
        return CGSize(width: ScreenWidth, height: itemHeight)
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int {
        if collectionView.tag == 299 {
            return 8
        }
        return person == nil ? 5 : person.cards!.count+3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
    }
    
}


class MoreViewController: ELPushedController {
    
    
    
    
    
}




class ELCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        guard attributes != nil else { return nil }
        for i in 1..<attributes!.count {
            let curr = attributes![i]
            let origin = attributes![i-1].frame.maxX
            //let maxSpacing = 0 ,下面左边要加上 max，x 右边也加 max.详见https://www.2cto.com/kf/201411/355481.html
            if origin + curr.frame.width <= collectionViewContentSize.width {
                curr.frame.origin.x = origin
            }
        }
        return attributes
    }
    
}






