//
//  FooterBaseView.swift
//  打折啦
//
//  Created by Eric on 05/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
class ELFooterBaseView: UIView {
    
    var button1: RoundButton!
    var button2: RoundButton!
    var button3: RoundButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = UIColor.white
        let effc = UIBlurEffect(style: .extraLight)
        let effcView = UIVisualEffectView(effect: effc)
        addSubview(effcView)
        effcView.snp.makeConstraints { make in
            make.center.size.equalTo(self)
        }
        
    }
    
    
    func setupOneTab(title: String, corner: CGFloat = 5, font: UIFont) {
       
        button1 = RoundButton()
        button1.fillBasic(corner: corner, txt: title, back: Config.themeColor.withAlphaComponent(0.9))
        button1.titleLabel?.font = font
        addSubview(button1)
        button1.snp.makeConstraints{ (make) in
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.top.equalTo(4)
            make.bottom.equalTo(-3)
        }

    }
    
    func setupTwoTab(title: (String, String), corner: CGFloat = 3.5, size: CGFloat = 17) {
        button1 = RoundButton()
        button1.fillBasic(corner: corner, txt: title.0, tint: UIColor.black, borderW: 0.5, size: size)
        button1.backgroundColor = UIColor.white
        addSubview(button1)
        let left: CGFloat = 10
        let w = ScreenWidth*0.5 - 1.5*left
        button1.snp.makeConstraints{ (make) in
            make.left.equalTo(left)
            make.width.equalTo(w)
            make.top.equalTo(left*0.5)
            make.bottom.equalTo(-0.5*left)
        }
        
        button2 = RoundButton()
        button2.fillBasic(corner: corner, txt: title.1, back: Config.themeColor, size: size)
        addSubview(button2)
     
        button2.snp.makeConstraints{ (make) in
            make.right.equalTo(-left)
            make.top.bottom.width.equalTo(button1)
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
}








