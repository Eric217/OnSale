//
//  Model.swift
//  Application
//
//  Created by Eric on 7/23/17.
//  Copyright © 2017 Eric. All rights reserved.
//

import Foundation
import UIKit

enum Str {
    
    static let idKey = "id"
    static let phoneKey = "phone"
    static let nickNameKey = "nickName"
    static let psdKey = "psd"
    static let emailKey = "email"
    static let genderKey = "gender"
    
}

//实现NSObject和NSCoding。NSObject可以不加，用@objc修饰某些方法也可以。
//NSCoding接口提供了序列化和反序列化对象的时候的编解码方法。
class Person: NSObject, NSCoding {
   
    var id:Int!
    var phone:String!
    var nickName:String!
    var psd:String!
    var email:String?
    var gender:String!
    
    ///序列化一个对象的时候使用
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: Str.idKey)
        aCoder.encode(phone, forKey: Str.phoneKey)
        aCoder.encode(nickName, forKey: Str.nickNameKey)
        aCoder.encode(psd, forKey: Str.psdKey)
        aCoder.encode(email, forKey: Str.emailKey)
        aCoder.encode(gender, forKey: Str.genderKey)

    }
    ///反序列化的时候用
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: Str.idKey) as? Int
        phone = aDecoder.decodeObject(forKey: Str.phoneKey) as? String
        nickName = aDecoder.decodeObject(forKey: Str.nickNameKey) as? String
        psd = aDecoder.decodeObject(forKey: Str.psdKey) as? String
        email = aDecoder.decodeObject(forKey: Str.emailKey) as? String
        gender = aDecoder.decodeObject(forKey: Str.genderKey) as? String

    }
    
}
extension UserDefaults {
    
    //先介绍下 synchronize() 方法，你代码让存一个字符串，并不是立即写到磁盘，而是每隔一段时间系统才写入，调用这个方法立即写入防止数据丢失。
    
    ///存储 自定义对象：
    func saveCustomObj(_ obj: NSCoding, key: String){
       
        let encodedObj = NSKeyedArchiver.archivedData(withRootObject: obj)
        set(encodedObj, forKey: key)
        synchronize()
        
    }
    ///获取 自定义对象：
    func getCustomObj(for key: String) -> Any? {
        
        guard let decodedObj = object(forKey: key) as? Data else{
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(with: decodedObj)

    }
    ///存储基本数据类型
    func saveBasic(_ value: Any?, for key: String) {
        set(value, forKey: key)
        synchronize()
    }

}















