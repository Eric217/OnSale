//
//  ELToolBar.swift
//  打折啦
//
//  Created by Eric on 11/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation

class ToolItemView0: BackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        img.snp.updateConstraints { make in
            make.width.height.equalTo(18)
        }
        txt.snp.updateConstraints { make in
            make.width.equalTo(25)
            make.height.equalTo(18)
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
class ToolItemView: UIView {
    var innerView: ToolItemView0!
    override init(frame: CGRect) {
        super.init(frame: frame)
        innerView = ToolItemView0()
        addSubview(innerView)
        innerView.snp.makeConstraints { make in
            make.width.equalTo(45)
            make.height.equalTo(18)
            make.center.equalTo(self)
        }
    }
    
    func setup(_ aimg: UIImage, title: String) {
        innerView.img.image = aimg
        innerView.txt.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ELToolBar: UIView {
    
    var button1: ToolItemView!
    var button2: ToolItemView!
    var button3: ToolItemView!
    var button4: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let effc = UIBlurEffect(style: .extraLight)
        let effcView = UIVisualEffectView(effect: effc)
        addSubview(effcView)
        effcView.snp.makeConstraints { make in
            make.center.size.equalTo(self)
        }
        
        let w = ScreenWidth*0.25
        button1 = ToolItemView(frame: myRect(0, 0, w, 44))
        addSubview(button1)
        button1.setup(#imageLiteral(resourceName: "small"), title: "留言")
        
        button2 = ToolItemView(frame: myRect(w, 0, w, 44))
        addSubview(button2)
        button2.setup(#imageLiteral(resourceName: "small"), title: "收藏")
        
        button3 = ToolItemView(frame: myRect(w*2, 0, w, 44))
        addSubview(button3)
        button3.setup(#imageLiteral(resourceName: "small"), title: "咨询")
        
        button4 = UIButton(frame: myRect(w*3, 0, w, 44))
        addSubview(button4)
        button4.backgroundColor = Config.themeColor
        button4.setTitle("到这去", for: .normal)
        
    }
    
    
  
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

