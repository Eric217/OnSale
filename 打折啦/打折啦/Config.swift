//
//  Config.swift
//  打折啦
//
//  Created by Eric on 7/21/17.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
import UIKit


//数字键盘：5.5吋226，4.7吋216，4.0吋216
//正常：5.5吋271，4.7吋258，4.0吋253
let ScreenHeight = UIScreen.main.bounds.height
let ScreenWidth = UIScreen.main.bounds.width


let UI_IS_LANDSCAPE = UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight
let UI_IPAD = UIDevice.current.userInterfaceIdiom == .pad
let UI_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
let UI_IPHONE4 = UI_IPHONE && ScreenHeight < 568.0
let UI_IPHONE5 = UI_IPHONE && ScreenHeight == 568.0
let UI_IPHONE6 = UI_IPHONE && ScreenHeight == 667.0
let UI_IPHONE6P = UI_IPHONE && ScreenHeight == 736.0 || ScreenWidth == 736.0

let UI_IOS8_ = UIDevice.current.systemVersion//格式：10.3.1
let UI_IOS = Int(UI_IOS8_.components(separatedBy: ".").first!)!


func myRect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}


enum Config {
    
    static func themeFont(_ ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica", size: ofSize)!
    }
    static let themeColor = UIColor(red: 1, green: 0.5, blue: 0.3, alpha: 1)
    
    
    
    
    
}
