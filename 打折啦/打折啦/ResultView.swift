//
//  ResultView.swift
//  打折啦
//
//  Created by Eric on 10/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
extension Identifier {
    static let resultofSearchCellId = "dnakdqweqdkj"
}
extension ResultController {
    
    func setupBar() {
        view.backgroundColor = UIColor.groupTableViewBackground
        fd_prefersNavigationBarHidden = true
        navBar = SearchingNavBar()
        view.addSubview(navBar)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        tap.delegate = self
        navBar.addGestureRecognizer(tap)
        navBar.search.delegate = self
        navBar.cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        navBar.selectButton.addTarget(self, action: #selector(shaixuan), for: .touchUpInside)
        navBar.all.changeStatus(true)
        navBar.search.text = keyword
    }
 
    func setupCollection() {
        let lay = UICollectionViewFlowLayout()
        collection = UICollectionView(frame: myRect(0, 104, ScreenWidth, ScreenHeight-104), collectionViewLayout: lay)
        collection.delegate = self
        collection.dataSource = self
        collection.register(ELItemViewCell.self, forCellWithReuseIdentifier: Identifier.resultofSearchCellId)
        view.addSubview(collection)
        
        refreshFooter = MJRefreshAutoNormalFooter {
            self.currPage += 1
            self.loadData(page: self.currPage)
        }
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = UIColor.groupTableViewBackground
    }
    
}

extension ResultController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.resultofSearchCellId, for: indexPath) as! ELItemViewCell
        cell.fillContents(dataArr[indexPath.item])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let vc = DetailController()
        vc.item = dataArr[indexPath.item] as! Good
        pushWithoutTab(vc)
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 13, left: lineSpacing, bottom: 0, right: lineSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemCellW, height: itemCellH)
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int {
        if dataArr.count == 0 {
            collection.mj_footer = nil
        }else {
            collection.mj_footer = refreshFooter
        }
        return dataArr.count
        
    }
    
}














