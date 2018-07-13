//
//  UIView.swift
//  打折啦
//
//  Created by Eris on 2017/8/17.
//  Copyright © 2017年 INGStudio. All rights reserved.
//

import Foundation

extension UITextField {
    
    func psdMod() {
        placeholder = "请输入密码"
        isSecureTextEntry = true
        clearsOnBeginEditing = true
        clearButtonMode = .whileEditing
        keyboardType = .asciiCapable
        autocorrectionType = .no
    }
    
   
    
    func addTitleLabel(_ label: UILabel, _ ofSize: CGFloat = 17) {
        label.textAlignment = .center
        label.textColor = Config.themeGray
        label.font = Config.themeFont(ofSize)
        addSubview(label)
        label.snp.makeConstraints{ make in
            make.bottom.equalTo(self.snp.top).inset(4)
            make.centerX.width.equalTo(self)
            make.height.equalTo(30)
        }
    }
    
    
    
    func addRightView(_ myView: UIView) {
        
        addSubview(myView)
        myView.snp.makeConstraints{ make in
            make.left.equalTo(self.snp.right)
            make.bottom.equalTo(self)
            make.size.equalTo(self.snp.height)
        }
        
        
    }
    
    
    func addConstraintY(centerY: CGFloat, right: CGFloat) {
        snp.makeConstraints{ (make) in
            make.height.equalTo(45)
            make.left.equalTo(right)
            make.right.equalTo(-right)
            make.centerY.equalTo(centerY)
        }
        
    }
    
}



