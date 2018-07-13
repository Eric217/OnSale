//
//  PersonCell2.swift
//  打折啦
//
//  Created by Eric on 11/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
///高44,分17+27
class ELPersonCell2: UIView {
    
    var head: UIImageView!
    var nameLabel: AttributedLabel!
    var realImg: UIImageView!
    var typeLabel: AttributedLabel!
    var dateLabel: AttributedLabel!
    var ddlLabel: AttributedLabel!
    
    let headHeight: CGFloat = 44
    let nameHei: CGFloat = 27
    let nameFont: CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        head = UIImageView()
        head.clipsToBounds = true
        head.contentMode = .scaleAspectFill
        addSubview(head)
        head.layer.cornerRadius = headHeight*0.5
        head.snp.makeConstraints{ make in
            make.width.height.equalTo(headHeight)
            make.centerY.equalTo(self)
            make.left.equalTo(2)
        }
        
        nameLabel = AttributedLabel()
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.systemFont(ofSize: nameFont, weight: UIFontWeightSemibold)
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(head.snp.right).offset(8)
            make.width.equalTo(10)
            make.height.equalTo(nameHei)
            make.top.equalTo(0)
        }

        dateLabel = AttributedLabel()
        dateLabel.textColor = UIColor.gray
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(0)
            make.width.equalTo(70)
            make.height.equalTo(headHeight-nameHei)
        }
      
        ddlLabel = AttributedLabel()
        ddlLabel.contentAlignment = .right
        ddlLabel.textColor = .red
        let ddlFosize: CGFloat = IPHONE5 ? 17.5 : 19
        ddlLabel.font = UIFont.boldSystemFont(ofSize: ddlFosize)
        addSubview(ddlLabel)
        ddlLabel.snp.makeConstraints { make in
            make.right.bottom.equalTo(0)
            make.width.equalTo(120)
            make.height.equalTo(nameHei+1)
        }
    }
    ///Good to be trans in
    override func fillContents(_ content: Any?) {
        let good = content as! Good
        head.sd_setImage(with: Router.getPicURL(good.user.id), placeholderImage: #imageLiteral(resourceName: "headholder"))
        let str = good.user.nickName
        nameLabel.setAutoWidenText(str!, fontSize: nameFont, max: mySize(ScreenWidth-145, nameHei))
        setStatus(itemType: good.type, personType: good.user.type)
        dateLabel.text = good.date.getDaysBefore() + "发布"
        ddlLabel.text = good.deadline.getDaysAfter()
    }
    
    func setStatus(itemType: Int, personType: Int?) {
        if itemType >= 100 {
            addReal()
            addType()
        }else if personType != 0 {
            addReal()
        }
    }
    
    func addReal() {
        realImg = UIImageView(image: #imageLiteral(resourceName: "realname"))
        addSubview(realImg)
        realImg.snp.makeConstraints { make in
            make.width.height.equalTo(18)
            make.left.equalTo(nameLabel.snp.right).offset(3)
            make.centerY.equalTo(nameLabel)
        }
    }
    
    func addType() {
        typeLabel = AttributedLabel()
        addSubview(typeLabel)
        typeLabel.clipsToBounds = true
        typeLabel.font = UIFont.systemFont(ofSize: 13)
        typeLabel.contentAlignment = .center
        typeLabel.initial(txt: "商品认证", color: Config.themeColor)
        typeLabel.snp.makeConstraints{ make in
            make.width.equalTo(57)
            make.height.equalTo(headHeight-nameHei-1)
            make.right.equalTo(0)
            make.top.equalTo(2.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}








