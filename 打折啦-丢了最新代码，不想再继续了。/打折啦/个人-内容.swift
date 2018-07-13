//
//  Person系列个人信息.swift
//  打折啦
//
//  Created by Eric on 03/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation

let headImgHeight: CGFloat = 62

class PersonSelfView: UIView {
    
    var head: WhiteCircleImageView!
    var nameLabel: AttributedLabel!
    var markLabel: AttributedLabel!
    var fansLabel: AttributedLabel!
    var genderImg: UIImageView!
    var title: RoundButton!
    var right: UIImageView!
    
    let nameFontSize: CGFloat = 21
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        head = WhiteCircleImageView()
        addSubview(head)
        let borderW: CGFloat = 2
        let leftD: CGFloat = IPHONE5 ? 11 : 18
        head.initialize(border: borderW)
        head.snp.makeConstraints{ make in
            make.left.equalTo(leftD)
            make.centerY.equalTo(self)
            make.width.height.equalTo(headImgHeight+2*borderW)
        }
        
        let x0 = leftD*2+headImgHeight+2*borderW
        let y0 = 41-headImgHeight/2-borderW
        
        
        nameLabel = AttributedLabel(frame: myRect(IPHONE5 ? x0 - 2 : x0 + 2, y0, 20, 25))
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: nameFontSize, weight: UIFontWeightMedium)
        addSubview(nameLabel)
       
        
        genderImg = UIImageView()
        genderImg.backgroundColor = UIColor.clear
        genderImg.contentMode = .scaleAspectFit
        addSubview(genderImg)
        genderImg.snp.makeConstraints{ make in
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.width.height.equalTo(20)
            make.centerY.equalTo(nameLabel)
        }
        
        
        markLabel = AttributedLabel()
        markLabel.textColor = UIColor.white.withAlphaComponent(0.77)
        markLabel.font = UIFont.systemFont(ofSize: 12)
        addSubview(markLabel)
        markLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(head)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        
        fansLabel = AttributedLabel()
        fansLabel.textColor = UIColor.white.withAlphaComponent(0.77)
        fansLabel.font = UIFont.systemFont(ofSize: 12)
        addSubview(fansLabel)
        fansLabel.snp.makeConstraints { make in
            make.left.equalTo(markLabel.snp.right).offset(15)
            make.bottom.width.height.equalTo(markLabel)
        }

        
        title = RoundButton()
        let b: CGFloat = IPHONE5 ? 1 : 1.5
        title.fillBasic(corner: 3.5, txt: "普通会员", tint: UIColor.white, borderW: b, size: 10)
        addSubview(title)
        title.snp.makeConstraints { make in
            make.left.equalTo(markLabel)
            make.centerY.equalTo(head).offset(3)
            make.width.equalTo(48)
            make.height.equalTo(15.5)
        }
        
        
        right = UIImageView()
        right.image = UIImage(named: "rightW")
        right.contentMode = .scaleAspectFit
        addSubview(right)
        right.snp.makeConstraints { make in
            make.right.equalTo(-12)
            make.centerY.equalTo(self)
            make.width.equalTo(20)
            make.height.equalTo(30)
        }
        
    }
    
    override func fillContents(_ content: Any?) {
        guard let peo = (content as? Person) else { return }
        let w = autoCalculateSize(peo.nickName, size: nameFontSize, maxSize: CGSize(width: ScreenWidth-120, height: 25)).width
        nameLabel.frame.size.width = w+3
        genderImg.image = UIImage(named: peo.gender!)
        nameLabel.text = peo.nickName
        title.setTitle(personType[peo.type!], for: .normal)
        let mark1 = "积分: \(peo.mark!)"
        markLabel.text = mark1
        markLabel.snp.updateConstraints{ make in
            let newW = autoCalculateSize(mark1, size: 12, maxSize: CGSize(width: 100, height: 20)).width
            make.width.equalTo(newW)
        }
        fansLabel.text = "粉丝: \(peo.fans!)"
        let phi = UIImage(named: "headholder")
        if peo.head == nil {
            head.imgView.sd_setImage(with: Router.getPicURL(peo.id), placeholderImage: phi, options: .refreshCached, completed: {
            img, _, _, _ in //img, error, isFromCache? , url
                if img == nil {
                    self.head.imgView.image = phi
                }
            })
        }else {
            head.imgView.image = peo.head
        }       
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}





