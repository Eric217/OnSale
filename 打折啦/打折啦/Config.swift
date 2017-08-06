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
let numBoardSmall:CGFloat = 216

let UI_IS_LANDSCAPE = UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight
let UI_IPAD = UIDevice.current.userInterfaceIdiom == .pad
let UI_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
let UI_IPHONE4 = UI_IPHONE && ScreenHeight < 568.0
let UI_IPHONE5 = UI_IPHONE && ScreenHeight == 568.0
let UI_IPHONE6 = UI_IPHONE && ScreenHeight == 667.0
let UI_IPHONE6P = UI_IPHONE && ScreenHeight == 736.0 || ScreenWidth == 736.0
let UI_IOS8_ = UIDevice.current.systemVersion//格式：10.3.1
let UI_IOS = Int(UI_IOS8_.components(separatedBy: ".").first!)!

let serverError = "responseValidationFailed(Alamofire.AFError.ResponseValidationFailureReason.unacceptableStatusCode(502))"
let netError = "responseValidationFailed(Alamofire.AFError.ResponseValidationFailureReason.unacceptableStatusCode(502))"



func myRect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}
func myRange(_ location: Int, _ length: Int) -> NSRange {
    return NSRange(location: location, length: length)
}
func myColor(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ alpha: CGFloat = 1) -> UIColor {
    return UIColor(red: r/255, green: g/255, blue: b/255, alpha: alpha)
}

enum Config {
    
    static func themeFont(_ ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica", size: ofSize)!
    }
    static let themeColor = UIColor(red: 1, green: 0.5, blue: 0.3, alpha: 1)
    
    static let themeGray = UIColor.lightGray
    static func predicate(_ type: String, _ content: String) -> Bool {
        let predicator = NSPredicate(format: "SELF MATCHES %@", type)
        return predicator.evaluate(with: content)
    }
    static let systemBlue = myColor(0, 118, 255)
    
}
enum Regex {
    static let name = "^(?!.*\\s).{1,12}$"
    static let pswd = "^(?!.*\\s).{8,16}$"
    static let email = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$"
    static let phone = "^1[3-9]{1}[0-9]{9}$"

}











