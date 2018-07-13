//
//  Exten.swift
//  Application
//
//  Created by Eric on 7/21/17.
//  Copyright © 2017 Eric. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setBackgroundImage(named img: String){
        layer.contents = UIImage(named: img)?.cgImage
        layer.contentsGravity = kCAGravityResizeAspectFill
    }
    
    func addAttributeLabel(_ label: UILabel, _ layoutHandler: () -> Void) {
        addSubview(label)
        layoutHandler()
        let str1 = "已阅读并同意使用条款和隐私政策"
        let str1len = str1.len()
        let attStr = NSMutableAttributedString(string: str1)
        
        attStr.addAttribute(NSFontAttributeName, value: Config.themeFont(12), range: myRange(0,str1len))
        attStr.addAttribute(NSForegroundColorAttributeName, value: Config.themeGray, range: myRange(0,6))
        attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: myRange(6, 4))
        attStr.addAttribute(NSForegroundColorAttributeName, value: Config.themeGray, range: myRange(10, 1))
        attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: myRange(11, 4))
        
        label.attributedText = attStr
        label.textAlignment = .center
//        label.yb_addAttributeTapAction(["使用条款","隐私政策"]){
//            (str, range, int) in
//            self.navigationController?.pushViewController(WebViewController(), animated: true)
//        }

        
    }
    
    ///初始化涂层
    /// - Parameters:

    ///   - change: 改变的程度，0～1 不变—变白
    /// - Returns: Void
    func setupGradient(_ gradient: CAGradientLayer = CAGradientLayer()) {
        gradient.frame = bounds
        gradient.shadowColor = UIColor.clear.cgColor
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        layer.addSublayer(gradient)
    }
    func setGradientLayerColor(_ color: UIColor, by: CGFloat = 0.36) {
        let layers = layer.sublayers
        guard layers != nil else { return }
        for l in layers! {
            let l0 = l as? CAGradientLayer
            if l0 != nil {
                let color1 = color.getWhiter(by: by)
                l0!.colors = [color.cgColor, color1.cgColor]
                break
            }
        }
    }
    
    //to be overridden
    func fillContents(_ content: Any?) {}
    
    func addBottomLine(height: CGFloat = 0.75, color: UIColor = Config.themeGray, bottom: CGFloat = 1000, left: CGFloat = 0) {
        let separator = UIView()
        if color.cgColor.alpha == 1 {
            separator.backgroundColor = color.withAlphaComponent(0.6)
        }else {
            separator.backgroundColor = color
        }
        addSubview(separator)
        separator.snp.makeConstraints{ (make) in
            make.left.equalTo(left)
            make.right.equalTo(-left)
            make.height.equalTo(height)
            guard bottom != 1000 else {
                make.bottom.equalTo(self); return
            }
            make.bottom.equalTo(bottom)

        }
    }
    
    func addTapGest(target: Any?, action: Selector?) {
        let ges = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(ges)
    }
    
    ///提供UIView背景的方法。传入要显示的layer。暂未考虑子控件手势劫持。
    func changeBackLayer(_ layer0: CALayer) {
        layer.addSublayer(layer0)
        layer0.zPosition = -1
        layer.backgroundColor = UIColor.clear.cgColor
        
    }
    
    ///该方法仅限之前 makeConstraint {} 里写过 make.width.equalTo(aValue)
    func updateWidth(_ w: CGFloat) {
        snp.updateConstraints { make in
            make.width.equalTo(w)
        }
    }
    
    func addBlurEffect(_ aFrame: CGRect? = nil) {
        
        let effc = UIBlurEffect(style: .extraLight)
        let effcView = UIVisualEffectView(effect: effc)
        addSubview(effcView)
        if aFrame == nil {
            effcView.snp.makeConstraints { make in
                make.center.size.equalTo(self)
            }
        }else {
            effcView.frame = aFrame!
        }
    }
    
    func getRound(corners: UIRectCorner = [UIRectCorner.topRight, UIRectCorner.topLeft], radii: CGSize = CGSize(width: 6, height: 6)) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: radii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
}











