//
//  Exten.swift
//  Application
//
//  Created by Eric on 7/21/17.
//  Copyright © 2017 Eric. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UIView {
    
    func setBackgroundImage(named img: String){
        layer.contents = UIImage(named: img)?.cgImage
        layer.contentsGravity = kCAGravityResizeAspectFill
    }
    
    func addAttributeLabel(_ label: UILabel, _ layoutHandler: () -> Void) {
        addSubview(label)
        layoutHandler()
        let str1 = "已阅读并同意使用条款和隐私政策"
        let str1len = str1.len()
        let attStr = NSMutableAttributedString(string: str1)
        
        attStr.addAttribute(NSFontAttributeName, value: Config.themeFont(12), range: myRange(0,str1len))
        attStr.addAttribute(NSForegroundColorAttributeName, value: Config.themeGray, range: myRange(0,6))
        attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: myRange(6, 4))
        attStr.addAttribute(NSForegroundColorAttributeName, value: Config.themeGray, range: myRange(10, 1))
        attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: myRange(11, 4))
        
        label.attributedText = attStr
        label.textAlignment = .center
//        label.yb_addAttributeTapAction(["使用条款","隐私政策"]){
//            (str, range, int) in
//            self.navigationController?.pushViewController(WebViewController(), animated: true)
//        }

        
    }
    
    
}
extension UITextField {
    
    func psdMod() {
        placeholder = "请输入密码"
        isSecureTextEntry = true
        clearsOnBeginEditing = true
        clearButtonMode = .whileEditing
        keyboardType = .asciiCapable
        autocorrectionType = .no
    }
    
    func addBottomLine(height: CGFloat,color: UIColor = Config.themeGray) {
        let separator = UIView()
        separator.backgroundColor = color.withAlphaComponent(0.6)
        addSubview(separator)
        separator.snp.makeConstraints{ (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(self)
            make.height.equalTo(height)
        }
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
extension UILabel {
    
    func animateText(_ duration: Double, goal: CGFloat) {
        textColor = Config.themeGray.withAlphaComponent(1-goal)
        UIView.animate(withDuration: duration, animations: {
            self.textColor = Config.themeGray.withAlphaComponent(goal)
        })
        
    }
    
}
extension String {
    func len() -> Int {
        return NSString(string: self).length
    }
}

extension DataRequest {
    
}




