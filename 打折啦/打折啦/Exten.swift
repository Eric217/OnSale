//
//  Exten.swift
//  Application
//
//  Created by Eric on 7/21/17.
//  Copyright © 2017 Eric. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setBackgroundImage(named img: String){
        layer.contents = UIImage(named: img)?.cgImage
        layer.contentsGravity = kCAGravityResizeAspectFill
    }
    
    
    
    
}
extension UITextField {
    
    func psdMod() {
        placeholder = "请输入密码"
        clearsOnBeginEditing = true
        clearButtonMode = .whileEditing
        keyboardType = .asciiCapable
        autocorrectionType = .no
    }
    
    func addBottomLine(height: CGFloat,color: UIColor = Config.themeGray) {
        let separator = UIView()
        separator.backgroundColor = color
        addSubview(separator)
        separator.snp.makeConstraints{ (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(self)
            make.height.equalTo(height)
        }
    }
    
    func addTitleLabel(_ label: UILabel) {
        label.textAlignment = .center
        label.textColor = Config.themeGray
        label.font = Config.themeFont(17)
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
extension UILabel {
   
    
}
extension String {
    func len() -> Int {
        return NSString(string: self).length
    }
}




