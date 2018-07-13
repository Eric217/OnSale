//
//  of_Others.swift
//  打折啦
//
//  Created by Eris on 2017/8/17.
//  Copyright © 2017年 INGStudio. All rights reserved.
//

import Foundation



extension Array {
    ///转三级地址专用
    func convert() -> [String] {
        let a = self as! [String]
        if a[0] == "全部" {
            return ["ALL", "ALL", "ALL"]
        }else if a[1] == "全部" {
            return [a[0], "ALL", "ALL"]
        }else if  a[2] == "全部" {
            return [a[0], a[1], "ALL"]
        }
        return a
    }
    
}

extension String {
    func len() -> Int {
        return NSString(string: self).length
    }
    func getDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: self)
    }
    
    func getDaysBefore(_ withDesc: Bool = true) -> String {
        
        let secon = Date().timeIntervalSince(getDate()!)
        let hour = Int(secon)/3600
        if hour == 0 {
            if withDesc { return "刚刚发布"}
            else { return "刚刚" }
        }else if hour < 24 {
            return "\(hour)小时前"
        }else if hour < 24*30 {
            return "\(hour/24)天前"
        }else if hour < 24*30*12 {
            return "\(hour/720)月前"
        }else {
            return "\(hour/(720*12))年前"
        }
    }
    func getDaysAfter() -> String {
        let secon = getDate()!.timeIntervalSinceNow
        let hour = Int(secon)/3600
        if hour == 0 {
            return "即将结束"
        }else if hour < 24 {
            return "还剩\(hour)时"
        }else if hour < 24*30 {
            return "还剩\(hour/24)天"
        }else if hour < 24*30*12 {
            return "\(hour/720)个月"
        }else {
            return "\(hour/(720*12))年"
        }
        
    }
   
}
extension Int {
    func getLevel() -> Int {
        if self < 110 {
            return 1
        }else if self < 180 {
            return 2
        }else if self < 320 {
            return 3
        }else if self < 500 {
            return 4
        }else if self < 720 {
            return 5
        }else if self < 1000 {
            return 6
        }
        return 7
    }
}

