//
//  PersonViewController.swift
//  frame
//
//  Created by Eric on 7/14/17.
//  Copyright © 2017 Eric. All rights reserved.
//

import Foundation
import UIKit
class PersonViewController: UIViewController {
    
    var tableView:UITableView!
    var v:UIImageView?
    
    var isHidden = false
    let speed:CGFloat = 5
    
    
    //MARK: - 加与除 观察者
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.addObserver(self, forKeyPath: "contentOffset", options: [.old, .new], context: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.removeObserver(self, forKeyPath: "contentOffset", context: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Me"
  
    
       
        
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        v = UIImageView(frame: CGRect(x: 0, y: -200, width: view.bounds.width, height: 200))
        v?.image = UIImage()
        v?.contentMode = .scaleAspectFill
        v?.clipsToBounds = true
        
        tableView.contentInset = UIEdgeInsets(top: 200-64, left: 0, bottom: 0, right: 0)
        tableView.addSubview(v!)

        
        
        view.addSubview(tableView)
        
    }
    
    //MARK: - KVO 响应方法 心态爆炸！！！！！！！！！
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
       
        guard keyPath == "contentOffset" else{
            print("error: KVO not equal")
            return
        }
//        print("start to process")
//        let oldY = ((change![NSKeyValueChangeKey.oldKey] as? CGPoint)?.y)!
//        let newY = ((change![NSKeyValueChangeKey.newKey] as? CGPoint)?.y)!
//        
//        let i = newY-oldY
//        
//        // offset记忆方法，正常滑动 是正值，硬往上拉弹回来是负值
//        
//        print(i)
//        if newY > -64 && newY <= 24 {
//            if i<=0 && isHidden == false && (navigationController?.navigationBar.frame.origin.y)! == 20 {
//                return
//            }
//            isHidden = false
//            setY(newY)
//        }else if newY > 24 {
//            if i>10 {
//                isHidden = true
//            }else if i < -10 {
//                isHidden = false
//            }
//        }
//        hide(isHidden)
    }
    func hide(_ toHide: Bool){
        if toHide {
            setY(-20)
        }else{
            setY(-64)
        }
        
    }
    func setY(_ Y: CGFloat){
        navigationController?.navigationBar.frame.origin.y = Y
    }
    
}

    
    
    


extension PersonViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return 48
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
       
        return " "
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 35
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        
    }
    
}








