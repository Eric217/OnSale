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
    
    func addBottomLine(height: CGFloat,color: UIColor) {
        let separator = UIView()
        separator.backgroundColor = color
        addSubview(separator)
        separator.snp.makeConstraints{ (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(self)
            make.height.equalTo(height)
        }
    }
    
    
}





