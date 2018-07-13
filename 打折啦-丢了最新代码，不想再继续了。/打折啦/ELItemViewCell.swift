//
//  ELItemViewCell.swift
//  打折啦
//
//  Created by Eric on 10/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation

let lineSpacing: CGFloat = IPHONE6P ? 15 : (IPHONE6 ? 12 : 10)
let itemCellW: CGFloat = (ScreenWidth - 3 * lineSpacing)/2
let unitH: CGFloat = 22
let itemCellH: CGFloat = itemCellW + 3 * unitH

///item size: (ScreenWidth - 3*5)/2, width + 3*20
class ELItemViewCell: UICollectionViewCell {
    
    var imgView: UIImageView!
    var title: AttributedLabel!
    var tip1: UIImageView!
    var tip2: AttributedLabel!
    var location: AttributedLabel!
    var date: AttributedLabel!
    
    let left: CGFloat = IPHONE6P ? 9 : (IPHONE6 ? 7.5 : 6)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        getRound()
        imgView = UIImageView()
        addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.width.height.equalTo(self.snp.width)
            make.left.top.equalTo(0)
        }
        
        title = AttributedLabel()
        title.font = UIFont.systemFont(ofSize: 14.5)
        addSubview(title)
        
        title.snp.makeConstraints { make in
            make.left.equalTo(left)
            make.right.equalTo(-2)
            make.height.equalTo(unitH)
            make.top.equalTo(imgView.snp.bottom)
        }
        
        location = AttributedLabel()
        addSubview(location)
        location.textColor = .gray
        location.font = UIFont.systemFont(ofSize: 12)
        location.snp.makeConstraints { make in
            make.left.height.equalTo(title)
            make.width.equalTo(itemCellW*0.7)
            make.bottom.equalTo(self)
        }
        
        date = AttributedLabel()
        addSubview(date)
        date.contentAlignment = .right
        date.textColor = .gray
        date.font = UIFont.systemFont(ofSize: 12)
        date.snp.makeConstraints { make in
            make.height.equalTo(title)
            make.right.equalTo(-left)
            make.top.equalTo(location)
            make.left.equalTo(location.snp.right)
        }
    }
    ///传进来 Good 对象
    override func fillContents(_ content: Any?) {
        let item = content as! Good
        imgView.sd_setImage(with: URL(string: item.smallPics[0]), placeholderImage: #imageLiteral(resourceName: "plhd"))
        title.text = item.title
        setStatus(itemType: item.type, personType: item.user.type)
        let city = item.threeLevel[1]
        location.text = city.substring(to: city.endIndex) + " " + item.threeLevel[2]
        date.text = item.date.getDaysBefore()
    
    }
    func addTip1() {
        tip1 = UIImageView()
        tip1.backgroundColor = UIColor.clear
        tip1.contentMode = .scaleAspectFit
        tip1.image = #imageLiteral(resourceName: "realname")
        addSubview(tip1)
        tip1.snp.makeConstraints{ make in
            make.left.equalTo(left+4)
            make.width.equalTo(unitH)
            make.height.equalTo(20)
            make.top.equalTo(title.snp.bottom)
        }
    }
    
    func addTip2(hasTip1: Bool) {
        tip2 = AttributedLabel()
        tip2.clipsToBounds = true
        tip2.font = UIFont.systemFont(ofSize: 13)
        tip2.contentAlignment = .center
        
        if hasTip1 {
            tip2.initial(txt: "商品认证", color: Config.themeColor)
        }else {
            tip2.initial(txt: "未认证", color: .gray)
        }
        addSubview(tip2)
        tip2.snp.makeConstraints{ make in
            make.width.equalTo(57)
            make.height.equalTo(17)
            if hasTip1 {
                make.left.equalTo(tip1.snp.right).offset(8)
            }else {
                make.left.equalTo(left+1)
            }
            make.centerY.equalTo(location).offset(-unitH)
        }
    }
    
    func setStatus(itemType: Int, personType: Int?) {
        if itemType >= 100 {
            addTip1()
            addTip2(hasTip1: true)
        }else if personType == 0 {
            addTip2(hasTip1: false)
        }else {
            addTip1()
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}





