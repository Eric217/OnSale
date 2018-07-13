//
//  ELPushedController.swift
//  打折啦
//
//  Created by Eric on 04/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation

///使用方法：不要担心 bar，viewdidLoad最后写 addBar（）。可以重写返回方法(默认有返回方法)，可以添加右侧手势
class ELPushedController: UIViewController {
    
    var navBar: ELBackNavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fd_prefersNavigationBarHidden = true
        navBar = ELBackNavigationBar()
        navBar.setBackColor(Config.themeColor)
    }
    
    func addBar(_ title: String = "", rightText: String) {
        if title != "" {
            navBar.setupTitle(title)
        }
        navBar.setRightText(rW: CGFloat(20*rightText.len()), rightT: rightText)
        addTapGest(isRight: false, target: self, action: #selector(back))
        view.addSubview(navBar)
    }
    
    func addBar(_ title: String = "") {
        if title != "" {
            navBar.setupTitle(title)
        }
        addTapGest(isRight: false, target: self, action: #selector(back))
        view.addSubview(navBar)
    }

    
    func addBar(_ title: String = "", rightImg: String) {
        if title != "" {
            navBar.setupTitle(title)
        }
        navBar.setRightImage(rightImg)
        addTapGest(isRight: false, target: self, action: #selector(back))
        view.addSubview(navBar)
    }

    
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func addTapGest(isRight: Bool = true, target: Any?, action: Selector?) {
        if !isRight {
            navBar.backButton.addTapGest(target: target, action: action)
        }else {
            navBar.rightButton.addTapGest(target: target, action: action)
        }
    }
    
    
}








