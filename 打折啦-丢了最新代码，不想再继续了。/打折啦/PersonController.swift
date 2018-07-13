//
//  PersonViewController.swift
//  frame
//
//  Created by Eric on 7/14/17.
//  Copyright © 2017 Eric. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

///一个最大cell的大小 220
let itemHeight: CGFloat = 220
///title 大小
let titleHeight: CGFloat = 42

class PersonViewController: UIViewController {
    
    var collection: UICollectionView!
    var header: UIView!
    var navBar: ELMeNavigationBar!
    var refreshHeader: MJRefreshHeader!
    
    var isHidden = false
    let speed: CGFloat = 5
    let itemSpace: CGFloat = 10
    
    var person: Person!
    var navBarGradientLayer: CAGradientLayer!
    var addCard: AddCardButton!
    
    
    var pushType: Int! = 0
    
    let dataArr = ["我的发布", "我的评价", "我的圈子"
        , "我的小蜜", "更换皮肤", "游戏中心", "记账本", "我的信用", "必备工具", "查看全部工具"]
    
    //MARK: - Will_Appear,DidLoad,导航栏按钮事件

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collection.addObserver(self, forKeyPath: contentOffset, options: [.old, .new], context: nil)
        guard person != nil else { return }
        guard userDefau.integer(forKey: currentKey) == person?.key else {
            hud.setDefaultMaskType(.none)
            hud.show()
            loadData(); return
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        hud.dismiss()
        hud.setDefaultMaskType(.clear)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshHeader = MJRefreshNormalHeader{
            self.loadData(refresh: true)
        }
        setupCollectionView()
        setupBar()
        loadData()
    }
    
    @objc func setting() {
        pushWithoutTab(SettingsController())
        
        
    }
    
    @objc func scan() {
        
        
        
    }
    ///凡是能进入didTap方法的，都已return true.
    @objc func didTap(_ sender: UITapGestureRecognizer) {
        switch pushType {
        case 200: pushWithoutTab(MoreViewController())
        case 10:
            let vc = PersonSelfController()
            vc.people = person
            pushWithoutTab(vc)
        case 20: pushWithoutTab(CollectedItemController())
        case 21: pushWithoutTab(CaredItemController())
        case 22: pushWithoutTab(HistoryItemController())
        case 100: pushWithoutTab(MoreViewController())
        default: break
        }                    
     
    }

   
  
}

//MARK: - Tap、KVO响应, Will_Disappear, Theme

extension PersonViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let loc = touch.location(in: collection)
        let idx = collection.indexPathForItem(at: loc)
        
        guard idx != nil else {
            let lo = touch.location(in: addCard)
            if addCard.bounds.contains(lo) {
                print(hh+"dian ji le button plus")
            }
            return false
        }
        
        let item = collection.cellForItem(at: idx!)
        if idx?.row == 0 {
            let it = item as! ELPersonViewCell
            var per: UIView = it.personView
            if per.bounds.contains(touch.location(in: per)) {
                pushType = 10; return true
            }
            per = it.collect
            if per.bounds.contains(touch.location(in: per)) {
                pushType = 20; return true
            }
            per = it.care
            if per.bounds.contains(touch.location(in: per)) {
                pushType = 21; return true
            }
            per = it.hist
            if per.bounds.contains(touch.location(in: per)) {
                pushType = 22; return true
            }
        }else if idx?.row == 1 {
            
            
        }else if idx?.row == 2 {
            //let poi = touch.location(in: item)
            let title = (item as! ELToolViewCell).desc
            let p = touch.location(in: title)
            if title!.bounds.contains(p) {
                pushType = 200; return true
            }
        }
        
        
        return false
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "contentOffset" else{
            print("error: KVO not equal"); return
        }

        let newY = ((change![NSKeyValueChangeKey.newKey] as? CGPoint)?.y)!
        let standard = newY+20
        let totalHeight = -refreshHeight-refreshPlus
        
        if standard <= 0 {
            navBar.setAlpha_(0)
            if standard < totalHeight {
                collection.contentOffset = CGPoint(x: 0, y: totalHeight-20)
            }
        }else {
            if standard > 60 {
                navBar.setAlpha_(1); return
            }
            navBar.setAlpha_(standard/60)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        collection.removeObserver(self, forKeyPath: contentOffset, context: nil)
        
    }
   
    func changeTheme(_ color: UIColor, by: CGFloat = 0.4) {
        navBar.setBackColor(color, by: by)
        let cell = collection.cellForItem(at: IndexPath(item: 0, section: 0)) as! ELPersonViewCell
        cell.gradient.colors = [color.cgColor, color.getWhiter(by: by).cgColor]
        
        
        
        
        //TODO: - 发通知所有nav改色
        
    }
    
       
    
}










