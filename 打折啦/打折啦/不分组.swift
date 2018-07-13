//
//  DoubleDecker.swift
//  打折啦
//
//  Created by Eris on 22/08/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation

///用的时候 宽大于64，高大于91
class AddCardButton: UIView {
    
    var butt: UIButton!
    var labe: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.groupTableViewBackground
        butt = UIButton()
        butt.setTitle("+", for: .normal)
        butt.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        butt.backgroundColor = .white
        butt.layer.cornerRadius = 32
        butt.clipsToBounds = true
        addSubview(butt)
        
        labe = UILabel()
        labe.text = "添加卡片"
        labe.font = UIFont.systemFont(ofSize: 14)
        labe.textAlignment = .center
        addSubview(labe)
        
        butt.snp.makeConstraints { make in
            make.centerX.top.equalTo(self).offset(1)
            make.height.width.equalTo(64)
        }
        
        labe.snp.makeConstraints{ make in
            make.width.centerX.equalTo(butt)
            make.top.equalTo(butt.snp.bottom).offset(3)
            make.height.equalTo(23)
        }
        
    }
    
    func setColor(_ color: UIColor) {
        labe.textColor = color
        butt.titleLabel?.textColor = color
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

class WhiteCircleImageView: UIView {
    
    var imgView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        clipsToBounds = true
        
        imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = headImgHeight*0.5
        imgView.contentMode = .scaleAspectFill
        addSubview(imgView)
        imgView.snp.makeConstraints{ make in
            make.width.height.equalTo(headImgHeight)
            make.center.equalTo(self)
        }
    }
    
    func initialize(border: CGFloat) {
        layer.cornerRadius = headImgHeight*0.5+border
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







