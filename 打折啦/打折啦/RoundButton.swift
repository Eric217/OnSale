//
//  RoundButton.swift
//  打折啦
//
//  Created by Eric on 30/08/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
///
class RoundButton: UIButton {
    
    var status: Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true

    }
    ///默认灰色圆按钮
    func fillDefault(_ title_: String, font: UIFont = UIFont.systemFont(ofSize: 14) ) {
        layer.cornerRadius = 13
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 2
        setTitleColor(UIColor.lightGray, for: .normal)
        titleLabel?.font = font
        setTitle(title_, for: .normal)
    }
    
    ///带字的，背景色透明，字的颜色为tint
    func fillBasic(corner: CGFloat, txt: String, tint: UIColor, borderW: CGFloat = 2, size: CGFloat = 17) {
        layer.cornerRadius = corner
        layer.borderWidth = borderW
        layer.borderColor = tint.cgColor
        setTitle(txt, for: .normal)
        backgroundColor = UIColor.clear
        if tint == UIColor.white {
            setTitleColor(tint.withAlphaComponent(0.75), for: .normal)
        }else {
            setTitleColor(tint, for: .normal)
        }
        titleLabel?.font = UIFont.systemFont(ofSize: size)
        
    }
    
    ///带字的，背景色为 back，字的颜色为白色
    func fillBasic(corner: CGFloat, txt: String, back: UIColor, size: CGFloat = 17) {
        layer.cornerRadius = corner
        setTitle(txt, for: .normal)
        titleLabel?.textColor = .white
        backgroundColor = back
        titleLabel?.font = UIFont.systemFont(ofSize: size)
        
    }
    
    func fillImage(corner: CGFloat, borderColor: UIColor, borderW: CGFloat = 2, img: String) {
        layer.cornerRadius = corner
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderW
        setImage(UIImage(named: img), for: .normal)
        
        
    }
    
    func changeStatus(_ hasImage: Bool = false) {
        status = !status
        if !status {
            setTitleColor(UIColor.lightGray, for: .normal)
            if hasImage {
                layer.borderColor = UIColor.clear.cgColor
            }else {
                layer.borderColor = UIColor.lightGray.cgColor
            }
            tintColor = UIColor.lightGray
        }else{
            layer.borderColor = Config.themeColor.cgColor
            setTitleColor(Config.themeColor, for: .normal)
            tintColor = Config.themeColor
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    
    
}






