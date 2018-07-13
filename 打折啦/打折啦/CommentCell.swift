//
//  CommentCell.swift
//  打折啦
//
//  Created by Eric on 13/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation

extension Identifier {
    static let commentCellId = "cajhcbeha"
    static let likeCellId = "cahcbcasa"
    static let imgCellId = "ajndchacnkad"

}

class ELCommentCell: UITableViewCell {
    
    var head: UIImageView!
    var nameLabel: AttributedLabel!
    var realImg: UIImageView!
    var masterSign: AttributedLabel?
    var txtLa: AttributedLabel!
    var dateLabel: AttributedLabel!
    
    let headHeight: CGFloat = 30
    var heigh: CGFloat = 1
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        head = UIImageView()
        head.clipsToBounds = true
        head.contentMode = .scaleAspectFill
        addSubview(head)
        head.layer.cornerRadius = headHeight*0.5
        head.snp.makeConstraints{ make in
            make.width.height.equalTo(headHeight)
            make.left.equalTo(20)
            make.top.equalTo(15)
        }
        
        nameLabel = AttributedLabel()
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.systemFont(ofSize: 14.5, weight: UIFontWeightSemibold)
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(head.snp.right).offset(10)
            make.width.equalTo(10)
            make.height.centerY.equalTo(head)
        }
        
        txtLa = AttributedLabel()
        txtLa.textColor = .black
        txtLa.font = UIFont.systemFont(ofSize: 17)
        addSubview(txtLa)
        txtLa.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(head.snp.bottom).offset(-2)
            make.width.equalTo(ScreenWidth-85)
            make.height.equalTo(25)
        }

        
        dateLabel = AttributedLabel()
        dateLabel.textColor = UIColor.gray
        dateLabel.font = UIFont.systemFont(ofSize: 12.5)
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(self).offset(-5)
            make.width.equalTo(80)
            make.height.equalTo(15)
        }
        
    }
    
    ///传来一个comment对象
    override func fillContents(_ content: Any?) {
        let commen = content as! Comment
        head.sd_setImage(with: Router.getPicURL(commen.user.id), placeholderImage: #imageLiteral(resourceName: "headholder"))
        let nam = commen.user.nickName
        nameLabel.text = nam
        let w = autoCalculateSize(nam!, size: 14.5, maxSize: mySize(ScreenWidth-100, 25)).width + 3
        nameLabel.snp.updateConstraints { make in
            make.width.equalTo(w)
        }
        
        txtLa.attributedText = getAttributed(commen.content, lineSpac: 4)
        let a = autoCalculateSize(commen.content, size: 17, maxSize: mySize(ScreenWidth-85, 100), lineSpa: 4).height + 3
        if a > 25 {
            txtLa.snp.updateConstraints { make in
                make.height.equalTo(a)
            }
        }
        if commen.user.type != 0 {
            addReal()
        }
        if commen.type == 1 {
            addMasterSign()
        }
        dateLabel.text = commen.getDateBefore()
        
        
    }
    
    func addReal() {
        realImg = UIImageView(image: #imageLiteral(resourceName: "realname"))
        addSubview(realImg)
        realImg.snp.makeConstraints { make in
            make.width.height.equalTo(17)
            make.left.equalTo(nameLabel.snp.right).offset(4)
            make.centerY.equalTo(nameLabel)
        }
    
    }
    
    func addMasterSign() {
    
        masterSign = AttributedLabel()
        addSubview(masterSign!)
        masterSign?.clipsToBounds = true
        masterSign?.font = UIFont.systemFont(ofSize: 13)
        masterSign?.contentAlignment = .center
        masterSign?.initial(txt: "上传者", color: Config.themeColor)
        masterSign?.snp.makeConstraints { make in
            make.width.equalTo(48)
            make.height.equalTo(17)
            make.right.equalTo(-18)
            make.centerY.equalTo(nameLabel)
        }
    
    }
    
   
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}







