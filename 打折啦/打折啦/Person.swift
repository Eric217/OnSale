//
//  Model.swift
//  Application
//
//  Created by Eric on 7/23/17.
//  Copyright © 2017 Eric. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

let isFirstOpened = "isFirstopened"
let isSignedKey = "isSignedIn"

let idKey = "id"
let phoneKey = "phone"
let nickNameKey = "nickName"
let psdKey = "psd"
let emailKey = "email"
let genderKey = "gender"
let headKey = "head"
let keyKey = "keyKey"
let toSaveKey = "toSavkey"
let cardsKey = "CardsKey"
let markKey = "markKeuf"
let typeKey = "typoeleu"
let realNameKey = "relanameky"
let realIdKey = "realidkEu"
let signatureKey = "sinateurekuy"
let birthdayKey = "biradaulkeu"
let fansKey = "fanskeu"

var userNumKey = "csdcwcdcea"
///获得用户时是 用户的key + userGeneralKey = userNum + userGeneralKey
let userGeneralKey = "APPUSER"


//实现NSObject和NSCoding。NSObject可以不加，用@objc修饰某些方法也可以。
//NSCoding接口提供了序列化和反序列化对象的时候的编解码方法。
class Person: NSObject, NSCoding {
   
    //云端值--------
    var id: Int!
    var phone: String!
    var nickName: String!
    var psd: String!
    var email: String?
    var gender: String!
    var mark: Int?
    var type: Int?
    var realName: String?
    var realID: String?
    var signature: String?
    var birthday: String?
    var fans: Int?
    
    //本地化的值-------
    var head: UIImage?
    var key: Int!
    var toSave: Bool!
    //人初始化就有俩卡片
    var cards: [Card]?
    
    init(save: Bool = false) {
        super.init()
        toSave = save; key = 0
    }
    
    ///构造和分析总是同时调用的
    func analyse(_ dict: NSDictionary) {
        #if DEBUG
            print("debugging")
        #else
        let data = JSON(dict)["data"].dictionaryValue
        
        id = data["id"]?.int
        phone = data["phone"]?.string
        mark = data["mark"]?.int
        type = data["type"]?.int
        gender = data["gender"]?.string
        nickName = data["nickName"]?.string
        psd = data["password"]?.string
        email = data["email"]?.string
        realName = data["realName"]?.string
        realID = data["realID"]?.string
        signature = data["signature"]?.string
        birthday = data["birthday"]?.string
        fans = data["fans"]?.int
            
        #endif
        //people构造完成，下面是存到本地，但是要确定多用户编号
        if toSave {
            var userNum = userDefau.integer(forKey: userNumKey)
            func add() {
                let basicCard1 = Card()
                let basicCard2 = Card()
                userNum += 1
                key = userNum
                userDefau.saveBasic(userNum, key: userNumKey)
                cards = [basicCard1, basicCard2]
            }
            if userNum == 0{
                add()
            }else{
                for i in 1...userNum {
                    let p = userDefau.getCustomObj(for: "\(i)"+userGeneralKey) as? Person
                    if id == p?.id {
                        cards = p?.cards
                        key = i; break
                    }
                }
                if key == 0 {
                    add()
                }
            }
            userDefau.saveBasic(key, key: currentKey)
            userDefau.saveBasic(id, key: currentIDKey)
            saveModel()
        }
    }
    
    func saveModel() {
        userDefau.saveCustomObj(self, key: "\(self.key!)"+userGeneralKey)
        Alamofire.request(Router.getPicURL(id)).responseData { response in
            switch response.result {
            case .failure(let e):
                print(dk, e)
            case .success(let v):
                self.head = UIImage(data: v)
                userDefau.saveCustomObj(self, key: "\(self.key!)"+userGeneralKey)
            }
        }
    }
    
    ///序列化一个对象的时候使用
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: idKey)
        aCoder.encode(phone, forKey: phoneKey)
        aCoder.encode(nickName, forKey: nickNameKey)
        aCoder.encode(psd, forKey: psdKey)
        aCoder.encode(email, forKey: emailKey)
        aCoder.encode(gender, forKey: genderKey)
        aCoder.encode(head, forKey: headKey)
        aCoder.encode(key, forKey: keyKey)
        aCoder.encode(toSave, forKey: toSaveKey)
        aCoder.encode(cards, forKey: cardsKey)
        aCoder.encode(mark, forKey: markKey)
        aCoder.encode(type, forKey: typeKey)
        aCoder.encode(realID, forKey: realIdKey)
        aCoder.encode(realName, forKey: realNameKey)
        aCoder.encode(signature, forKey: signatureKey)
        aCoder.encode(birthday, forKey: birthdayKey)
        aCoder.encode(fans, forKey: fansKey)
        
    }
    
    ///反序列化的时候用
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: idKey) as? Int
        phone = aDecoder.decodeObject(forKey: phoneKey) as? String
        nickName = aDecoder.decodeObject(forKey: nickNameKey) as? String
        psd = aDecoder.decodeObject(forKey: psdKey) as? String
        email = aDecoder.decodeObject(forKey: emailKey) as? String
        gender = aDecoder.decodeObject(forKey: genderKey) as? String
        head = aDecoder.decodeObject(forKey: headKey) as? UIImage
        key = aDecoder.decodeObject(forKey: keyKey) as? Int
        toSave = aDecoder.decodeObject(forKey: toSaveKey) as? Bool
        cards = aDecoder.decodeObject(forKey: cardsKey) as? [Card]
        mark = aDecoder.decodeObject(forKey: markKey) as? Int
        type = aDecoder.decodeObject(forKey: typeKey) as? Int
        realID = aDecoder.decodeObject(forKey: realIdKey) as? String
        realName = aDecoder.decodeObject(forKey: realNameKey) as? String
        signature = aDecoder.decodeObject(forKey: signatureKey) as? String
        birthday = aDecoder.decodeObject(forKey: birthdayKey) as? String
        fans = aDecoder.decodeObject(forKey: fansKey) as? Int
        
    }
    
}



extension UserDefaults {
    
    //synchronize() 方法: 代码让存一个字符串，并不是立即写到磁盘，而是每隔一段时间系统才写入，调用这个方法立即写入防止数据丢失。
    
    ///存储 自定义对象：
    func saveCustomObj(_ obj: NSCoding, key: String){
        
        let encodedObj = NSKeyedArchiver.archivedData(withRootObject: obj)
        set(encodedObj, forKey: key)
        print("Has saved a key: ",key)
        synchronize()
        
    }
    ///获取 自定义对象：
    func getCustomObj(for key: String) -> Any? {
        
        guard let decodedObj = object(forKey: key) as? Data else{
            print("getting obj but nil from key: ", key)
            return nil
        }
        print("Getting local obj from key: ", key)
        return NSKeyedUnarchiver.unarchiveObject(with: decodedObj)
        
    }
    ///存储基本数据类型
    func saveBasic(_ value: Any?, key: String) {
        set(value, forKey: key)
        synchronize()
    }
    
}











