//
//  of_UIKit.swift
//  打折啦
//
//  Created by Eric on 11/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
extension UILabel {
    
    func animateText(_ duration: Double, goal: CGFloat) {
        textColor = Config.themeGray.withAlphaComponent(1-goal)
        UIView.animate(withDuration: duration, animations: {
            self.textColor = Config.themeGray.withAlphaComponent(goal)
        })
    }
    
}

extension UIColor {
    
    func getWhiter(by per: CGFloat = 0.32) -> UIColor {
        if let compo = cgColor.components {
            if compo.count == 2 {
                return UIColor(white: compo[0] + per * (1 - compo[0]), alpha: compo[1])
            }else {
                return UIColor(red: compo[0] + per * (1 - compo[0]), green: compo[1] + per * (1 - compo[1]), blue: compo[2] + per * (1 - compo[2]), alpha: compo[3])
            }
        }else {
            return self
        }
    }
    
    func getImage() -> UIImage {
        let rect = myRect(0, 0, 1, 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(cgColor)
        context?.fill(rect)
        let i = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return i ?? UIImage()
    }
    
}

extension MJRefreshHeader {
    
    func setGradientWith(subView tag: Int, _ color: UIColor, by: CGFloat = 0.36) {
        let color1 = color.getWhiter(by: by)
        let cols = [color.cgColor, color1.cgColor]
        for i in subviews {
            if i.tag == tag {
                (i.layer.sublayers![0] as! CAGradientLayer).colors = cols;  break
            }
        }
        let layers = layer.sublayers
        if layers == nil { return }
        for l in layers! {
            let l0 = l as? CAGradientLayer
            if l0 != nil {
                l0!.colors = cols
                break
            }
        }
    }
    
}

extension UIViewController {
    
    func pushWithoutTab(_ vc: UIViewController, animated: Bool = true) {
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: animated)
    }
    
    
    func presentAlert(_ title: String?, _ msg: String?, _ style: UIAlertControllerStyle, actTitle: String, _ handler: ((UIAlertAction) -> Void)?) {
        let acon = UIAlertController(title: title, message: msg, preferredStyle: style)
        let aact = UIAlertAction(title: actTitle, style: .default, handler: handler)
        let aact1 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        acon.addAction(aact)
        acon.addAction(aact1)
        present(acon, animated: true, completion: nil)
        
    }
    func openURL(_ str: String = UIApplicationOpenSettingsURLString) {
        let url = URL(string: str)!
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
}

extension AttributedLabel {
    
    func initial(txt: String, corner: CGFloat = 3, color: UIColor, width: CGFloat = 1) {
        layer.cornerRadius = corner
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        textColor = color
        text = txt
    }
    
    func setAutoWidenText(_ txt: String, fontSize: CGFloat, max: CGSize, forceHeight: Bool = true) {
        text = txt
        let newS = autoCalculateSize(txt, size: fontSize, maxSize: max)
        snp.updateConstraints { make in
            make.width.equalTo(newS.width+10)
            if !forceHeight {
                make.height.equalTo(newS.height)
            }
        }
    }
    
    func setAutoHeightText(_ txt: String, fontSize: CGFloat, max: CGSize) -> CGFloat {
        attributedText = getAttributed(txt, lineSpac: 4)
        var a: CGFloat = 0
        snp.updateConstraints { make in
            a = autoCalculateSize(txt, size: fontSize, maxSize: max, lineSpa: 4).height+3
            make.height.equalTo(a)
        }
        return a

    }

    
    
}

extension CAGradientLayer {
    
    func setBack(_ color: UIColor, by: CGFloat = 0.55) {
        let color1 = color.getWhiter(by: by)
        colors = [color.cgColor, color1.cgColor]
    }
}






