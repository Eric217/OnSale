//
//  Comment.swift
//  打折啦
//
//  Created by Eric on 13/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
class Comment {
    var id: Int!
    var goodsId: Int!
    var user: Person!
    var content: String!
    var date: String!
    //0 default, 1 master
    var type = 0
    
    func analyse(_ info: JSON, upId: Int) {
        id = info["id"].int
       
        goodsId = info["goodID"].int
       
        let p = Person()
        p.analyse(info["user"].dictionaryObject! as NSDictionary)
        user = p
        content = info["content"].string
        date = info["date"].string
        
        if user.id == upId {
            type = 1
        }
    }
    
    func getDateBefore() -> String {
        return date.getDaysBefore(false)
    }
    
}





