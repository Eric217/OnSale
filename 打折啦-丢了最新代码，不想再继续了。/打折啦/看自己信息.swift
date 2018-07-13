//
//  Person详细.swift
//  打折啦
//
//  Created by Eric on 04/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation


extension Identifier {
    static let personViewCellId = "dsjfnkjqknyqt"
    static let rightLabelCellId = "sajfdhdkasjd"
}

  
class PersonSelfController: ELPushedController ,UITableViewDelegate, UITableViewDataSource {
    
    var people: Person!
    var table: UITableView!
    var v: UIImageView!
    
    let headImgHei:CGFloat = IPHONE6||IPHONE6P ? 220 : 195
    let dataArr = [["昵称", "个人简介", "积分与等级", "我的上传"], ["性别", "生日", "现居地"], ["手机号码", "邮箱", "实名认证", "商家认证"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .plain)
        table.backgroundColor = UIColor.groupTableViewBackground
        table.dataSource = self
        table.delegate = self
        table.register(ELPersonSmallCell.self, forCellReuseIdentifier: Identifier.personViewCellId)
        table.register(RightLabelCell.self, forCellReuseIdentifier: Identifier.rightLabelCellId)
        
        v = UIImageView(frame: myRect(0, -headImgHei, ScreenWidth, headImgHei))
        if people.head != nil {
            v?.image = people.head
        }else {
            v.image = UIImage(named: "headholder")
        }
        v?.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        
        table.contentInset = UIEdgeInsets(top: headImgHei-20, left: 0, bottom: 30, right: 0)
        table.addSubview(v!)
        view.addSubview(table)
        
        addBar("个人资料", rightText: "更换头像")
        navBar.setAlpha_(0)
        
    }
    
    //MARK: - delegate and data source
    
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let sec = indexPath.section
        let cellName = dataArr[sec][row]
        let m = people.mark!
        let t = people.type!
        var rightTxt = ""
        
        if row == 2 && sec == 0 {
            let cell = RightLabelCell2()
            cell.setRightText("Lv \(m.getLevel())", size: 18, color: .gray)
            cell.fillContents((cellName, m))
            return cell
        }
        
        if sec == 0 && (row == 0 || row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.personViewCellId) as? ELPersonSmallCell
            if row == 0 {
                rightTxt = people.nickName
                cell?.initForNickName(t, origMark: m)
            }else {
                if people.signature == "" {
                    rightTxt = unFilled
                }else {
                    rightTxt = people.signature!
                }
            }
            cell?.fillContents((cellName, rightTxt))
            return cell!
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.rightLabelCellId) as? RightLabelCell
        cell?.setLeftText(cellName)
        
        if sec == 0 && row == 3 {
            rightTxt = "查看全部上传"
        }else if sec == 1 {
            if row == 0 {
                rightTxt = people.gender
            }else if row == 1 {
                rightTxt = people.birthday == "1901-01-01" ? unFilled : people.birthday!
            }else {
                // fill people's current location
                rightTxt = unFilled
            }
        }else if sec == 2 {
            if row == 0 {
                rightTxt = people.phone
            }else if row == 1 {
                if people.email == "" {
                    rightTxt = "未验证"
                }else {
                    rightTxt = (people.email)!
                }
            }else if (row == 2 && t != 0) || (row == 3 && t == 2) {
                rightTxt = "已认证"
            }else {
                rightTxt = "未认证"
            }
        }
        cell?.setRightText(rightTxt)
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if row == 2 && sec == 0 {
//            let cell = RightLabelCell2()
//            cell.setRightText("Lv \(m.getLevel())", size: 18, color: .gray)
//            cell.fillContents((cellName, m))
//            return cell
//        }
//        
//        if sec == 0 && (row == 0 || row == 1) {
//            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.personViewCellId) as? ELPersonSmallCell
//            if row == 0 {
//                rightTxt = people.nickName
//                cell?.initForNickName(t, origMark: m)
//            }else {
//                if people.signature == "" {
//                    rightTxt = unFilled
//                }else {
//                    rightTxt = people.signature!
//                }
//            }
//            cell?.fillContents((cellName, rightTxt))
//            return cell!
//        }
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.rightLabelCellId) as? RightLabelCell
//        cell?.setLeftText(cellName)
//        
//        if sec == 0 && row == 3 {
//            rightTxt = "查看全部上传"
//        }else if sec == 1 {
//            if row == 0 {
//                rightTxt = people.gender
//            }else if row == 1 {
//                //TODO: - fill peole's birthday
//                rightTxt = unFilled
//            }else {
//                // fill people's current location
//                rightTxt = unFilled
//            }
//        }else if sec == 2 {
//            if row == 0 {
//                rightTxt = people.phone
//            }else if row == 1 {
//                rightTxt = (people.email)!
//            }else if (row == 2 && t != 0) || (row == 3 && t == 2) {
//                rightTxt = "已认证"
//            }else {
//                rightTxt = "未认证"
//            }
//        }
    
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offY = scrollView.contentOffset.y
        let nega = -headImgHei
        if offY < nega {
            v.frame.origin.y = offY
            v.frame.size.height = -offY
        }
        
        if offY <= nega {
            navBar.setAlpha_(0, withTitle: true)
        }else if offY >= -64 {
            navBar.setAlpha_(1)
        }else {
            let al = (nega - offY)/(64+nega)
            navBar.setAlpha_(al, withTitle: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 3
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row != 3 {
                return 64
            }
            return 49
        }
        return 52
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0
        }
        return 20
        //TODO: -  滑动时总是有毛病
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 2 { return nil }
        return " "
    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        if section == 2 { return nil }
//        let grayView = UIView(frame: myRect(0, 0, ScreenWidth, 20))
//        grayView.backgroundColor = UIColor.groupTableViewBackground
//        return grayView
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    
}


//0-4
//nickName type,LV // u d
//signature  // u d
//mark-level  // u d r
//upload // l r

//1-2
//gender  // l r
//birthday 还未加  // l r
//nowLocation // l r

//2-4
//phone   // l r
//email   // l r
//real,business  // l r







