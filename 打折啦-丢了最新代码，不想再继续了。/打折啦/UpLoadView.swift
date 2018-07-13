//
//  UpLoadViewController.swift
//  Application
//
//  Created by Eric on 7/15/17.
//  Copyright © 2017 Eric. All rights reserved.
//

import Foundation
import UIKit

class UpLoadViewController: HWPublishBaseController {
    
    
    var scrollView: UIScrollView!
    var headBar: ELMeNavigationBar!
    var footBar: ELFooterBaseView!
 
    var txf: UITextField!
    var txv: BRPlaceholderTextView!
    var scrollPhoto: UIScrollView!
    var location: UITableViewCell!
    var kind: RightLabelCell!
    var time: RightLabelCell!
    var business: RoundButton!
    var weChat: RoundButton!
    var qqZone: RoundButton!
    var question: RoundButton!
    
    
    
    var currPickerHeight: CGFloat!
    //var delta: CGFloat = 0
    
    var pic: [UIImage]!
    
    
    let placehold = "   在这里添加店铺楼层、门牌号等详细打折信息"
    let chooseLoca = "选择地点"
    let choosType = "选择种类"
    //大小11. arr[11]即视为arr[10]
    let timeArr = ["不足六小时", "今天", "两天", "三天", "五天", "七天", "十天", "十五天", "一个月", "两个月", "更长"]
    var dateArr: [String]!
    var type = -1
    var l1 = "", l2 = "", l3 = "", locaStr = ""
    var lon = 0.0, lat = 0.0
    var deadLine: String!
    
    
    
    
    func d(_ quarters: Int) -> String {
        return "\(Date(timeIntervalSinceNow: TimeInterval(60*60*6*quarters)))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let is6P = IPHONE6P
        let bigger6 = is6P || IPHONE6
        title = "发布"
        
        dateArr = [d(1),d(4),d(8),d(12),d(20),d(28),d(40),d(60),d(120),d(240),d(300)]
        deadLine = dateArr[3]
        print(dateArr)
        view.backgroundColor = UIColor.groupTableViewBackground
       
        //MARK: - 头部视图
        headBar = ELMeNavigationBar()
        view.addSubview(headBar)
        headBar.setupTitle("发布")
        headBar.setBackColor(Config.themeColor)
        headBar.setLeftRightTitle(left: "取消", right: "发布秘籍")
        headBar.setButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        headBar.codeButton.addTarget(self, action: #selector(showtip), for: .touchUpInside)
    
        //MARK: - footer view
        let footHeit: CGFloat = bigger6 ? 54 : 44
        footBar = ELFooterBaseView(frame: myRect(0, ScreenHeight-footHeit, ScreenWidth, footHeit))
        view.addSubview(footBar)
        footBar.setupOneTab(title: "确定发布", corner: 5, font: UIFont.boldSystemFont(ofSize: 18))
        
        footBar.button1.addTarget(self, action: #selector(fabu), for: .touchUpInside)
      
        
        scrollView = UIScrollView(frame: myRect(0, 64, ScreenWidth, ScreenHeight - 64 - 44))
        let contentH = scrollView.frame.height + (is6P ? 1 : (IPHONE6 ? 10 : 32))
        updateContentSize(value: contentH)
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = UIColor.groupTableViewBackground
        showInView = scrollView
        
        let txfHeight: CGFloat = is6P ? 55 : 48
        
        initPickerView()
        updatePickerViewFrameY(txfHeight)
        currPickerHeight = pickerCollectionView.frame.height
        
        txf = UITextField(frame: myRect(0, 0, ScreenWidth, txfHeight))
        txf.backgroundColor = .white
        scrollView.addSubview(txf)
        txf.font = UIFont.systemFont(ofSize: 17)
        txf.placeholder = "标题  一个合适的标题可以吸引更多人哦"
        txf.clearButtonMode = .whileEditing
        txf.delegate = self
        txf.returnKeyType = .done
        txf.addBottomLine(height: 0.5)
        txf.leftView = UIView(frame: myRect(0, 0, 12, txfHeight))
        txf.leftViewMode = .always
        
        location = UITableViewCell()
        location.backgroundColor = .white
        location.textLabel?.text = chooseLoca
        location.textLabel?.textColor = .gray
        scrollView.addSubview(location)
        location.accessoryType = .disclosureIndicator
        let cellHeight: CGFloat = is6P ? 49 : (bigger6 ? 46 : 42)
        location.snp.makeConstraints{ make in
            make.width.centerX.equalTo(pickerCollectionView)
            make.height.equalTo(cellHeight)
            make.top.equalTo(pickerCollectionView.snp.bottom)
        }
        location.addTapGest(target: self, action: #selector(didTap(_ :)))

        let groupColor = UIColor.groupTableViewBackground.withAlphaComponent(0.99)

        txv = BRPlaceholderTextView()
        txv.placeholder = placehold
        txv.font = UIFont.systemFont(ofSize: 16)
        txv.setPlaceholderFont(UIFont.systemFont(ofSize: 16))
        txv.returnKeyType = .next
        txv.delegate = self
        txv.maxTextLength = 200
        txv.textContainerInset = .init(top: 6, left: 12, bottom: 2, right: 16)
        
        scrollView.addSubview(txv)
        let txvHeight: CGFloat = bigger6 ? 138 : 95
        
        txv.snp.makeConstraints{ make in
            make.width.centerX.equalTo(txf)
            make.top.equalTo(location.snp.bottom).offset(12)
            make.height.equalTo(txvHeight)
        }
        
        let separator = UIView(frame: myRect(12, 0, ScreenWidth-12, 1))
        separator.backgroundColor = groupColor
        location.addSubview(separator)
        
        time = RightLabelCell()
        time.backgroundColor = UIColor.white
        time.setLeftText("持续时间")
        time.setRightText("三天")
        scrollView.addSubview(time)
        time.snp.makeConstraints{ make in
            make.width.centerX.equalTo(location)
            make.height.equalTo(cellHeight)
            make.top.equalTo(txv.snp.bottom).offset(12)
        }
        time.addTapGest(target: self, action: #selector(didTap(_ :)))
        
   
        kind = RightLabelCell()
        kind.setLeftText(choosType, color: .gray)
        kind.rightLabel.text = ""
        kind.backgroundColor = .white
        scrollView.addSubview(kind)
        kind.snp.makeConstraints{ make in
            make.width.height.centerX.equalTo(time)
            make.top.equalTo(time.snp.bottom)
        }
        kind.addTapGest(target: self, action: #selector(didTap(_ :)))

        let separator2 = UIView(frame: myRect(12, 0, ScreenWidth-12, 1))
        separator2.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        kind.addSubview(separator2)
        
        var _left: CGFloat = 23
        var _h: CGFloat = 28
        var _w: CGFloat = 90
        var _plus: CGFloat = 0
        if is6P {
            _left += 10; _h += 4; _w += 20; _plus = 18
            txv.font = UIFont.systemFont(ofSize: 18)
            txf.font = UIFont.systemFont(ofSize: 18)
        }else if !bigger6 { _left -= 3 }
        
        business = RoundButton()
        scrollView.addSubview(business)
        business.snp.makeConstraints{ make in
            make.left.equalTo(_left)
            make.width.equalTo(_w)
            make.height.equalTo(_h)
            make.top.equalTo(kind.snp.bottom).offset(_left)
        }
        business.fillDefault("我是商家", font: UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium))
        business.tag = 200
        business.layer.cornerRadius = 6
        business.addTarget(self, action: #selector(didClick(_ :)), for: .touchUpInside)

        question = RoundButton()
        scrollView.addSubview(question)
        question.snp.makeConstraints{ m in
            m.left.equalTo(business.snp.right).offset(10)
            m.width.height.equalTo(_h - 3)
            m.centerY.equalTo(business)
        }
        question.tag = 201
        question.fillBasic(corner: 13, txt: "?", tint: Config.systemBlue, borderW: 1, size: 14)
      
        question.addTarget(self, action: #selector(didClick(_ :)), for: .touchUpInside)
       
        /*
        qqZone = RoundButton()
        qqZone.tag = 202
        scrollView.addSubview(qqZone)
        qqZone.snp.makeConstraints{ m in
            m.left.equalTo(ScreenWidth-40-_plus-_left)
            m.centerY.equalTo(business)
            m.width.height.equalTo(53 + _plus)
        }
        qqZone.fillImage(corner: 8, borderColor: UIColor.clear, img: "qqzone")
        qqZone.addTarget(self, action: #selector(didClick(_ :)), for: .touchUpInside)
        
        weChat = RoundButton()
        weChat.tag = 203
        scrollView.addSubview(weChat)
        weChat.snp.makeConstraints{ m in
            m.right.equalTo(qqZone.snp.left).offset(-15)
            m.width.height.centerY.equalTo(qqZone)
        }
        weChat.fillImage(corner: 8, borderColor: UIColor.clear, img: "wechat")
        weChat.addTarget(self, action: #selector(didClick(_ :)), for: .touchUpInside)
        */
        
        navBarShadowImageHidden = true
        navBarBackgroundAlpha = 0
        navBarTintColor = UIColor.white
        fd_prefersNavigationBarHidden = true

    }

    
    
}





 /*
        view.backgroundColor = UIColor.white
        statusBarStyle = .lightContent
        var tempFrame = view.bounds
        tempFrame.origin.y = 15
        let maskPath = UIBezierPath(roundedRect: tempFrame, byRoundingCorners:
                    [UIRectCorner.topRight, UIRectCorner.topLeft], cornerRadii: CGSize(width: 30, height: 30))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = tempFrame
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer
        //view.frame.origin.y = 40
       
        let label = UILabel(frame: myRect(100, 200, 100, 200))
        label.backgroundColor = UIColor.red
        view.addSubview(label)
        UIView.animate(withDuration: 0.5, animations: {
            //self.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
//
        
 
//        let view2 = UIScrollView(frame: CGRect(x: 0, y: 30, width: view.bounds.width, height: view.bounds.height))
//        view2.backgroundColor = UIColor.white
//        let maskPath = UIBezierPath(roundedRect: view2.bounds, byRoundingCorners:
//            [UIRectCorner.topRight, UIRectCorner.topLeft], cornerRadii: CGSize(width: 5, height: 5))
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = view2.bounds
//        maskLayer.path = maskPath.cgPath
//        view2.layer.mask = maskLayer
//        view.addSubview(view2)
//        view2.isUserInteractionEnabled = true
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
//        view2.addGestureRecognizer(gesture)
        */
        






