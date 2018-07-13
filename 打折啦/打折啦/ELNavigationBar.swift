//
//  ELNavigationBar.swift
//  打折啦
//
//  Created by Eris on 2017/8/16.
//  Copyright © 2017年 INGStudio. All rights reserved.
//

import Foundation
import SnapKit

///仅提供了基本功能：title，背景色，透明度。
class ELBaseNavigationBar: UIView {
    
    var gradient: CAGradientLayer!
    
    var title: String?
    var titleLabel: UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        gradient = CAGradientLayer()
        setupGradient(gradient)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setAlpha_(_ alp: CGFloat, withTitle: Bool = false) {
        let c0 = gradient.colors?[0] as! CGColor
        if c0.alpha == alp {
            return
        }
        if withTitle {
            titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: alp)
        }
        gradient.colors = [c0.copy(alpha: alp) ?? UIColor.white.cgColor, (gradient.colors?[1] as! CGColor).copy(alpha: alp) ?? UIColor.white.cgColor]
 
    }
    
    func setupTitle(_ title: String) {
        titleLabel = UILabel()
        titleLabel?.text = title
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        titleLabel?.textAlignment = .center
        addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints{ make in
            make.width.equalTo(80)
            make.height.equalTo(44)
            make.centerY.equalTo(42)
            make.centerX.equalTo(self)
        }
    }
    
    func setBackColor(_ color: UIColor, by: CGFloat = 0.55) {
        let color1 = color.getWhiter(by: by)
        gradient.colors = [color.cgColor, color1.cgColor]
    }
    
   
    
}
















