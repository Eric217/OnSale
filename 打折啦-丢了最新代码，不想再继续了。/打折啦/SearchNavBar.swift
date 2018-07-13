//
//  SearchNavBar.swift
//  打折啦
//
//  Created by Eric on 25/08/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation

class ELSearchNavBar: ELMeNavigationBar {
    
    var search: UISearchBar!
    
    override init(){
        super.init()
        setLeftRightImage(left: "code", right: "more")
      
        search = UISearchBar()
        search.placeholder = "打折啦"
        search.tintColor = Config.themeColor
        search.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        addSubview(search)
        setButton.snp.updateConstraints{ make in
            make.bottom.equalTo(self).inset(IPHONE5 ? 8 : 9)
        }
        
        search.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.centerY.equalTo(setButton)
            let l = IPHONE5 ? 5 : 9
            make.left.equalTo(setButton.snp.right).offset(l)
            make.right.equalTo(codeButton.snp.left).offset(-l)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SearchResultNavBar: ELBaseNavigationBar {
    
    var search: UISearchBar!
    var cancelButton: UIButton!
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 64))
        setBackColor(Config.themeColor)
        
        cancelButton = UIButton()
        cancelButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.titleLabel?.textAlignment = .right
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.setTitle("取消", for: .normal)
        addSubview(cancelButton)
        cancelButton.snp.makeConstraints{ make in
            make.right.equalTo(-4)
            make.bottom.equalTo(self).inset(IPHONE5 ? 6 : 9)
            make.height.equalTo(24)
            make.width.equalTo(37)
        }

        search = UISearchBar()
        search.showsCancelButton = false
        search.placeholder = "搜索你想要的商品"
        search.tintColor = Config.themeColor
        search.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        addSubview(search)
        search.snp.makeConstraints{ make in
            make.height.equalTo(42)
            make.right.equalTo(cancelButton.snp.left).offset(-2)
            make.left.equalTo(self)
            make.centerY.equalTo(cancelButton)
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class SearchingNavBar: UIView {
    
    var gradient: CAGradientLayer!
    
    var search: UISearchBar!
    var cancelButton: UIButton!
    var selectButton: UIButton!
    
    var location: Mylabel!
    var all: Mylabel!
    var time: Mylabel!
    var distance: Mylabel!
    
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 64+40))
        gradient = CAGradientLayer()
        gradient.frame = myRect(0, 0, ScreenWidth, 64)
        layer.addSublayer(gradient)
        let color = Config.themeColor
        let color1 = color.getWhiter(by: 0.5)
        gradient.colors = [color.cgColor, color1.cgColor]
        
        selectButton = UIButton()
        selectButton.setTitleColor(UIColor.white, for: .normal)
        selectButton.titleLabel?.textAlignment = .right
        selectButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        selectButton.setTitle("筛选", for: .normal)
        addSubview(selectButton)
        selectButton.snp.makeConstraints{ make in
            make.right.equalTo(-5)
            make.bottom.equalTo(self).inset((IPHONE5 ? 6 : 9)+40)
            make.height.equalTo(24)
            make.width.equalTo(35)
        }
        
        cancelButton = UIButton()
        cancelButton.setBackgroundImage(#imageLiteral(resourceName: "leftW"), for: .normal)
        cancelButton.imageView?.contentMode = .scaleAspectFill
        addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.left.equalTo(7)
            make.width.equalTo(30)
            make.height.equalTo(60)
            make.centerY.equalTo(selectButton)
        }
        
        search = UISearchBar()
        search.showsCancelButton = false
        search.placeholder = "搜索你想要的商品"
        search.tintColor = Config.themeColor
        search.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        addSubview(search)
        search.snp.makeConstraints{ make in
            make.height.equalTo(42)
            make.right.equalTo(selectButton.snp.left).offset(-2)
            make.left.equalTo(cancelButton.snp.right).offset(2)
            make.centerY.equalTo(selectButton)
        }
        
        location = Mylabel(x: 0, w: 1.64, txt: "选择地点")
        location.addRightImage()
        addSubview(location)
        location.tag = 100
        all = Mylabel(x: location.frame.width-0.5, txt: "综合", fix: 0.5)
        all.tag = 101
        addSubview(all)
        time = Mylabel(x: location.frame.width+all.frame.width, txt: "时间")
        addSubview(time)
        time.tag = 102
        distance = Mylabel(x: time.frame.origin.x+time.frame.width, txt: "距离")
        addSubview(distance)
        distance.tag = 103
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class Mylabel: AttributedLabel {
    
    var bold = false
    var size: CGFloat = 16
    var _text: String!
    var img: UIImageView?
    /// w倍的五分之一屏宽
    init(x: CGFloat, w: CGFloat = 1.12, txt: String, fix: CGFloat = 0) {
       
        super.init(frame: myRect(x, 64, ScreenWidth*0.2*w+fix, 40))
        font = UIFont.systemFont(ofSize: size)
        textColor = UIColor.gray
        contentAlignment = .center
        backgroundColor = .white
        text = txt
        _text = txt
        isUserInteractionEnabled = true
    }
    
    func addRightImage() {
        img = UIImageView()
        img?.image = #imageLiteral(resourceName: "point")
        img?.contentMode = .scaleAspectFit
        addSubview(img!)
        img?.snp.makeConstraints { make in
            make.right.equalTo(self).offset(IPHONE5 ? 4 : -5)
            make.width.equalTo(30)
            make.height.equalTo(15)
            make.centerY.equalTo(self)
            
        }
    }
    
    @discardableResult func changeStatus(_ isBold: Bool) -> Bool {
        if bold == isBold {
            return bold
        }
        bold = isBold
        if bold {
            font = UIFont.systemFont(ofSize: size, weight: UIFontWeightBold)
            textColor = Config.themeColor
        }else {
            font = UIFont.systemFont(ofSize: size)
            textColor = UIColor.gray
        }
        return bold
    }
    
    @discardableResult func changeText(_ str: String, forceBold b: Bool) -> Bool {
        text = str
        return changeStatus(b)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





