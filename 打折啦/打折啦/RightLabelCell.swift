//
//  RightLabelCell.swift
//  打折啦
//
//  Created by Eric on 31/08/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation


class RightLabelCell: UITableViewCell {
    
    var rightLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        rightLabel = UILabel()
        rightLabel.textAlignment = .right
        accessoryType = .disclosureIndicator
        addSubview(rightLabel)
        rightLabel.snp.makeConstraints{ m in
            m.right.equalTo(-31)
            m.centerY.height.equalTo(self)
            m.width.equalTo(ScreenWidth*2/3+10)
        }
    }
    ///black, 17 by default
    func setRightText(_ str: String, size: CGFloat = 17, color: UIColor = .black) {
        rightLabel.text = str
        rightLabel.font = UIFont.systemFont(ofSize: size)
        rightLabel.textColor = color
    }
    ///gray by default
    func setLeftText(_ str: String, color: UIColor = .gray) {
        textLabel?.text = str
        textLabel?.textColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class RightLabelCell2: ELPersonSmallCell {
    
    var rightLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        rightLabel = UILabel()
        rightLabel.textAlignment = .right
        accessoryType = .disclosureIndicator
        addSubview(rightLabel)
        rightLabel.snp.makeConstraints{ m in
            m.right.equalTo(-35)
            m.centerY.height.equalTo(self)
            m.width.equalTo(ScreenWidth*2/3+10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRightText(_ str: String, size: CGFloat = 17, color: UIColor = .black) {
        rightLabel.text = str
        rightLabel.font = UIFont.systemFont(ofSize: size)
        rightLabel.textColor = color
    }

}








