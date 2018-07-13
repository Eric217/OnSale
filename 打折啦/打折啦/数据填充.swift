//
//  PersonModel.swift
//  打折啦
//
//  Created by Eric on 02/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
import Alamofire

extension PersonViewController {
    
    ///从网络获取数据
    func loadData(refresh: Bool = false) {

        Alamofire.request(Router.userInfo(Property.id, userDefau.integer(forKey: currentIDKey))).validate().responseJSON{
            response in
            switch response.result {
            case .success(let value):
                guard let info = value as? NSDictionary else {
                    hud.showError(withStatus: "服务器未响应")
                    self.loadLocalData(); return
                }
                self.person = Person()
                self.person.analyse(info)
                self.fillInfo()
                hud.dismiss()
            case .failure(let error):
                print(dk, error)
                hud.showError(withStatus: "服务器未响应")
                
                self.loadLocalData()
            }
        }
        
    }
    
    ///从userDefaults里加载数据
    func loadLocalData() {
        print("load from local")
        let curKey = userDefau.integer(forKey: currentKey)
        person = userDefau.getCustomObj(for: "\(curKey)"+userGeneralKey) as? Person
        guard person != nil else {
            hud.showError(withStatus: "用户信息加载失败"); return
        }
        fillInfo()
    }
    
    ///有内容的person已准备好。
    func fillInfo() {
        refreshHeader.endRefreshing()
        print("filling info--------")
        collection.reloadData()
    }
    
}


//加到loadData内，防止下拉后卡死：
/*
 if refresh {
 let ti = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(tick), userInfo: nil, repeats: false)
 ti.fireDate = Date(timeIntervalSinceNow: 3)
 }
 
 func tick() {
 refreshHeader.endRefreshing()
 }
 */








