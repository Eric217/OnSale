//
//  PersonCell.swift
//  打折啦
//
//  Created by Eric on 04/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
class ELPersonSmallCell: UITableViewCell {
    
    var title: AttributedLabel!
    var content: AttributedLabel!
    
    var type: RoundButton?
    var level: RoundButton?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        title = AttributedLabel()
        title.font = UIFont.systemFont(ofSize: 16)
        title.textColor = UIColor.gray
        addSubview(title)
        title.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(5)
            make.height.equalTo(22)
            make.width.equalTo(95)
        }
        content = AttributedLabel()
        content.font = UIFont.systemFont(ofSize: 18.5)
        addSubview(content)
        content.snp.makeConstraints { make in
            make.left.equalTo(title).offset(1)
            make.bottom.equalTo(self).offset(-5)
            make.height.equalTo(32)
            make.width.equalTo(25)
        }
    }
    
    ///title 与 contents 填充
    /// - Parameters: 
    ///   - contents: (String, String)
    override func fillContents(_ contents: Any?) {
        guard let con = contents as? (String, String) else {
            let con1 = contents as! (String, Int)
            title.text = con1.0
            let str = "\(con1.1)"
            content.updateWidth(autoCalculateSize(str, size: 18, maxSize: mySize(ScreenWidth-95, 25)).width)
            content.text = str; return
        }
        title.text = con.0
        content.text = con.1
        content.updateWidth(autoCalculateSize(con.1, size: 18, maxSize: mySize(ScreenWidth-95, 25)).width+3)
    }
    
    func initForNickName(_ persontype: Int, origMark: Int) {
        type = RoundButton()
        type?.fillBasic(corner: 3.5, txt: personType[persontype], tint: Config.themeColor, borderW: 1.5, size: 10)
        addSubview(type!)
        type?.snp.makeConstraints{ make in
            make.left.equalTo(content.snp.right).offset(10)
            make.centerY.equalTo(content)
            make.width.equalTo(46)
            make.height.equalTo(16.5)
        }
        
        
        level = RoundButton()
        level?.fillBasic(corner: 3.5, txt: "Lv \(origMark.getLevel())", tint: Config.themeColor, borderW: 1.5, size: 10)
        addSubview(level!)
        level?.snp.makeConstraints { make in
            make.left.equalTo(type!.snp.right).offset(10)
            make.centerY.height.equalTo(type!)
            make.width.equalTo(26)
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}









