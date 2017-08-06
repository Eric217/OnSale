//
//  Model.swift
//  Application
//
//  Created by Eric on 7/23/17.
//  Copyright © 2017 Eric. All rights reserved.
//

import Foundation
import UIKit

let isFirstOpened = "isFirstopened"
let isSignedKey = "isSignedIn"

let idKey = "id"
let phoneKey = "phone"
let nickNameKey = "nickName"
let psdKey = "psd"
let emailKey = "email"
let genderKey = "gender"

var userNumKey = 0
let userKey = "APPUSER"


//实现NSObject和NSCoding。NSObject可以不加，用@objc修饰某些方法也可以。
//NSCoding接口提供了序列化和反序列化对象的时候的编解码方法。
class Person: NSObject, NSCoding {
   
    var id:Int!
    var phone:String!
    var nickName:String!
    var psd:String!
    var email:String?
    var gender:String!
    
    
    
    var key = 0
    
    ///序列化一个对象的时候使用
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: idKey)
        aCoder.encode(phone, forKey: phoneKey)
        aCoder.encode(nickName, forKey: nickNameKey)
        aCoder.encode(psd, forKey: psdKey)
        aCoder.encode(email, forKey: emailKey)
        aCoder.encode(gender, forKey: genderKey)

    }
    override init() {
        super.init()
    }
    init(_ userkey: Int) {
        super.init()
        key = userkey
    }
    
    ///反序列化的时候用
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: idKey) as? Int
        phone = aDecoder.decodeObject(forKey: phoneKey) as? String
        nickName = aDecoder.decodeObject(forKey: nickNameKey) as? String
        psd = aDecoder.decodeObject(forKey: psdKey) as? String
        email = aDecoder.decodeObject(forKey: emailKey) as? String
        gender = aDecoder.decodeObject(forKey: genderKey) as? String

    }
    
    func analyse(_ dict: NSDictionary, save: Bool) {
        
        
        currentID = id
        
        
        
        if save {
            UserDefaults.standard.saveCustomObj(self, key: "\(userNumKey)"+userKey)
        }
        
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
    func saveBasic(_ value: Any?, key: String) {
        set(value, forKey: key)
        synchronize()
    }
    
}











