//
//  Item.swift
//  打折啦
//
//  Created by Eris on 22/08/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation

class Good {
    
    var id: Int!
    var user: Person!
    var type: Int!
    var isValid: Int!
    
    var long: Double!
    var lati: Double!
    
    var title: String!
    var description: String!
    
    var threeLevel: [String]!
    var location: String!
    
    var date: String!
    var deadline: String!
    
    var picRatio: String!
    var pics: [String]!
    var smallPics: [String]!
    
    ///info是 最小的那个字典，id = ···，······
    func anlyse(_ value: JSON) {
        
        id = value["id"].int
        type = value["type"].int
        let people = Person()
        people.analyse(value["user"].dictionaryObject! as NSDictionary)
        user = people
        isValid = value["isValid"].int
        long = value["longitude"].double
        lati = value["latitude"].double
        title = value["title"].string
        description = value["description"].string
        
        threeLevel = [value["l1"].string!, value["l2"].string!, value["l3"].string!]
        location = value["location"].string
        date = value["date"].string
        deadline = value["deadline"].string
        
        picRatio = value["picRatio"].string
        pics = value["pic"].arrayObject as? [String]
        smallPics = convertSize(pics)
    }
    
    //大图变小兔
    func convertSize(_ former: [String]) -> [String] {
        var new = (former as NSArray).copy() as! [String]
        for i in 0..<former.count {
            // _sm.png
            let idx = former[i].index(former[i].endIndex, offsetBy: -3)
            let r = Range(uncheckedBounds: (lower: former[i].index(before: idx), upper: idx))
            new[i] = former[i].replacingCharacters(in: r, with: "_sm.")
            
        }
        return new
    }
    
}









