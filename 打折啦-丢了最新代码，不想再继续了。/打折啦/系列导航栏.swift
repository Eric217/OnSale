//
//  MeNavigationBar.swift
//  打折啦
//
//  Created by Eris on 19/08/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation


///此类初始化后是左边字，右边图,调用setDefault初始化。两边字的调用setLeftRightTitle，两边图的调用setLeftRightImage
class ELMeNavigationBar: ELBaseNavigationBar {
    
    var setButton: UIButton!
    var codeButton: UIButton!
  
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 64))

        setButton = UIButton()
        setButton.setTitleColor(UIColor.white, for: .normal)
        setButton.titleLabel?.textAlignment = .left
        setButton.imageView?.contentMode = .scaleAspectFit

        addSubview(setButton!)
        setButton.snp.makeConstraints{ make in
            make.height.equalTo(24)
            make.width.equalTo(47)
            make.left.equalTo(IPHONE5 ? 9 : 15)
            make.bottom.equalTo(self).inset(IPHONE5 ? 10 : 12)
        }
        
        codeButton = UIButton()
        codeButton.backgroundColor = UIColor.clear
        codeButton.titleLabel?.textAlignment = .right
        codeButton.imageView?.contentMode = .scaleAspectFit
        addSubview(codeButton)
        codeButton.snp.makeConstraints{ make in
            make.right.equalTo(-12)
            make.centerY.equalTo(setButton)
            make.height.equalTo(22)
            make.width.equalTo(22)
        }
        
    }
    func setDefault(title: String, img: String) {
        setButton.setTitle(title, for: .normal)
        codeButton.setBackgroundImage(UIImage(named: img), for: .normal)
    }

    func setLeftRightTitle(rW: CGFloat = 80, left: String = "", right: String = "") {
        codeButton.snp.updateConstraints{ make in
            make.width.equalTo(rW)
            make.right.equalTo(-7)
        }
        setButton.setTitle(left, for: .normal)
        codeButton.setTitle(right, for: .normal)
    }
    
    
    func setLeftRightImage(left: String = "", right: String = "") {
        setButton.snp.updateConstraints { make in
            make.width.equalTo(22)
        }
        setButton.setBackgroundImage(UIImage(named: left), for: .normal)
        codeButton.setBackgroundImage(UIImage(named: right), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


///宽高 52 24
class BackView: UIView {
    var txt: AttributedLabel!
    var img: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        txt = AttributedLabel()
        img = UIImageView()
        img.image = UIImage(named: "leftW")
        addSubview(img)
        img.contentMode = .scaleAspectFill
        img.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.centerY.equalTo(self)
            make.width.equalTo(25)
            make.height.equalTo(50)
        }
        txt.textColor = UIColor.white
        txt.text = "返回"
        //txt.font = UIFont.systemFont(ofSize: 17.5)
        addSubview(txt)
        txt.snp.makeConstraints { make in
            make.left.equalTo(img.snp.right).offset(1)
            make.width.equalTo(40)
            make.centerY.equalTo(img)
            make.height.equalTo(24)
        }
    }
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ELBackNavigationBar: ELBaseNavigationBar {
    
    var backButton: BackView!
    var rightButton: UIButton!
    
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 64))
        
        backButton = BackView()
        addSubview(backButton)
        backButton!.snp.makeConstraints{ make in
            make.left.equalTo(10)
            make.bottom.equalTo(self).inset(10)
            make.height.equalTo(25)
            make.width.equalTo(64)
        }
        
        rightButton = UIButton()
        rightButton.backgroundColor = UIColor.clear
        rightButton.titleLabel?.textColor = UIColor.white
        rightButton.titleLabel?.textAlignment = .right
        rightButton.imageView?.contentMode = .scaleAspectFit
        addSubview(rightButton)
        rightButton.snp.makeConstraints{ make in
            make.right.equalTo(-8)
            make.width.equalTo(25)
            make.centerY.equalTo(backButton!)
            make.height.equalTo(25)
        }
        setFontSize(17.5)
    }
    
    func setFontSize(_ size: CGFloat) {
        let f = UIFont.systemFont(ofSize: size)
        backButton.txt.font = f
        rightButton.titleLabel?.font = f
    }
    
    func setRightText(rW: CGFloat = 90, rightT: String) {
        rightButton.snp.updateConstraints{ make in
            make.width.equalTo(rW)
        }
        rightButton.setTitle(rightT, for: .normal)
    }
    
    
    func setRightImage(_ right: String) {
        rightButton.setBackgroundImage(UIImage(named: right), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
/*
class ELTextNavigationBar: ELBaseNavigationBar {
    
    var leftItem: UIButton!
    var rightItem: UIButton!
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 64))
        
        leftItem = UIButton()
        leftItem.setTitleColor(.white, for: .normal)
        leftItem.titleLabel?.textAlignment = .left
        leftItem.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        //settile
        //leftItem.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        addSubview(leftItem)
        leftItem.snp.makeConstraints{ make in
            make.left.equalTo(10)
            make.bottom.equalTo(-10)
            make.height.equalTo(27)
            make.width.equalTo(50)
        }
        
        rightItem = UIButton()
        rightItem.titleLabel?.textAlignment = .right
        rightItem.setTitleColor(.white, for: .normal)
        rightItem.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        //rightItem.addTarget(self, action: #selector(showtip), for: .touchUpInside)
        addSubview(rightItem)
        rightItem.snp.makeConstraints{ make in
            make.right.equalTo(-10)
            make.height.centerY.equalTo(leftItem)
            make.width.equalTo(80)
        }
    }

    
    func setText(_ left: String, right: String) {
        leftItem.setTitle(left, for: .normal)
        rightItem.setTitle(right, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

*/













