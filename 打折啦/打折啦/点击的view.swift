//
//  点进去的view.swift
//  打折啦
//
//  Created by Eric on 11/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation

///收藏夹，关注，足迹那一栏的一个最小item的高度
let SmallItemHeight: CGFloat = 29

class DoubleDecker: UIView {
    
    var num: AttributedLabel!
    var txt: AttributedLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        num = AttributedLabel()
        num.isUserInteractionEnabled = true
        addSubview(num)
        txt = AttributedLabel()
        txt.isUserInteractionEnabled = true
        addSubview(txt)
        txt.contentAlignment = .center
        num.contentAlignment = .center
        txt.font = .systemFont(ofSize: 13)
        num.font = .systemFont(ofSize: 13)
        txt.textColor = .gray
        num.textColor = .gray
        num.snp.makeConstraints{ make in
            make.centerX.width.top.equalTo(self)
            make.height.equalTo(SmallItemHeight)
        }
        
        txt.snp.makeConstraints{ make in
            make.centerX.width.height.equalTo(num)
            make.top.equalTo(num.snp.bottom)
        }
    }
    
    func setNum(_ value: Int?, title: String = Identifier.txtVerifyId) {
        
        num.text = (value == 0 || value == nil) ? "- -" : "\(value!)"
        if title == Identifier.txtVerifyId { return }
        txt.text = title
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}




