//
//  必备-内容.swift
//  打折啦
//
//  Created by Eric on 11/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation

///嵌套的collectionView里的cell
class DoubleDeckerCell: UICollectionViewCell {
    
    var txt: AttributedLabel!
    var img: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        txt = AttributedLabel()
        txt.font = .systemFont(ofSize: 12)
        txt.textColor = .gray
        txt.contentAlignment = .center
        
        img = UIImageView()
        img.contentMode = .scaleAspectFit
        setUpDownConstr()
    }
    
    func setTxt(_ str: String = "测试", size: CGFloat = 13) {
        txt.text = str
        if size == 13 { return }
        txt.font = UIFont.systemFont(ofSize: size)
    }
    
    func setImg_(_ str: String = "tool1") {
        img.image = UIImage(named: str)
    }
    
    func setUpDownConstr(_ txtH: CGFloat = 30, _ imgH: CGFloat = 60) {
        addSubview(img)
        addSubview(txt)
        txt.snp.makeConstraints{ make in
            make.width.centerX.equalTo(self)
            make.height.equalTo(21)
            make.bottom.equalTo(self).offset(-12)
        }
        img.snp.makeConstraints{ make in
            make.centerX.equalTo(self)
            make.width.height.equalTo(ScreenWidth*0.25*0.25)
            make.bottom.equalTo(txt.snp.top).offset(-12)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

