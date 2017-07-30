//
//  Router.swift
//  打折啦
//
//  Created by Eric on 7/30/17.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
import Alamofire

let goods = "goodsID", favor = "favorite",
    comm = "commentID", history = "history"
enum Property {
    static let type = "type", gender = "gender", nickName = "nickName",
        password = "password", phone = "phone",realName = "realName",
        realID = "realID", signature = "signature", email = "email",id = "id"
}

//请求路由
enum Router:URLRequestConvertible {
    
    static let baseUrlStr = "http://139.199.39.220"

    ///只有 ID，name，email，phone
    case userInfo(String, Any)
    ///参数依次为 id类型(0-2:评论id，goodsID，userID), id_值, page, rows
    case getComment(Int, Int, Int, Int)
    ///type(0 favor,1 hist),page,rows
    case getFavorOrHist(Int, Int, Int)
    case upGood
    ///id,type,page,rows,userID,l1,l2,l3,title,isValid
    case getGoods(Int, Int, Int, Int, Int, String, String, String, String, Int)
    case addComment(goodID: Int, String)
    case addTo(String, Int)
    ///phone,name,psd
    case signUp(String, String, String)
    ///第一个只取 email，phone，nickName
    case validate(String, String)
    ///第一个只取 email，phone，nickName
    case signIn(String, String, psd: String)
    ///id,property,value
    case changeInfo(Int, String, Any)
    case changePic
    case delete(String, [Int])
    /// 3 phone, 1 code1, 2 code2
    case verify(Int, value: Any)
    
    func asURLRequest() throws -> URLRequest {
        
        let result: (path: String, para: Parameters) = {
            
            var str = "", params: [String: Any] = [:]
        
            switch self {
                
            case .userInfo(let code, let name):
                params = [code: name]
                return ("/anonymous/user/getUserInfo", params)
                
            case .signUp(let phone, let name, let psd):
                params = ["phone": phone, "nickName": name, "password": psd, "gender": "保密"]
                return ("/anonymous/signUp", params)
                
            case .validate(let code, let value):
                params = [code: value]
                return ("/anonymous/validateSignUp", params)
                
            case .changeInfo(let id, let property, let value):
                params = ["id": id, property: value]
                return ("/normal/user/changeInfo", params)
                
            case .signIn(let code, let value, let psd):
                params = [code: value, "password": psd]
                return ("/anonymous/user/signIn",params)
                
            case .getComment(let code, let name, let page, let rows):
                switch code {
                case 0: str = "id"
                case 1: str = "goodsID"
                case 2: str = "userID"
                default: break
                }
                params = [str: name, "page": page, "rows": rows]
                return ("/anonymous/comment/getComment", params)
                
            case .getFavorOrHist(let t, let p, let r):
                if t == 0 {
                    str = "/normal/favorite/getFavorite"
                }else{ str = "/normal/history/getHistory" }
                params = ["page": p, "rows": r]
                return (str, params)
                
            case .upGood:
                return ("/normal/goods/upload",params)
            
            case .getGoods(let id,let type,let p,let r,let uID,let l1,let l2,let l3,let ttl,let vali):
                params = ["id": id, "type": type, "page": p, "rows": r, "userID": uID, "l1": l1, "l2": l2, "l3": l3, "title": ttl, "isValid": vali]
                return ("/anonymous/goods/getGoods",params)
            
            case .delete(let name, let arr):
                params = [goods: arr]
                switch name {
                case goods: str = "/normal/goods/deleteGood"
                case favor: str = "/normal/favorite/deleteFavor"
                case comm:
                    str = "/normal/comment/deleteComment"
                    params = [comm: arr]
                case history:
                    str = "/normal/history/deleteHistory"
                    params = [:]
                default: break
                }
                return (str,params)
                
            case .addTo(let name, let id):
                str = "/normal/history/addHistory"
                if name == favor {
                    str = "/normal/favorite/addFavorite"
                }
                params = [goods: id]
                return (str, params)
                
            case .verify(let name, let value):
                params = ["code": value]
                switch name {
                case 3:
                    str = "/anonymous/verify/phone"
                    params = ["phone": value]
                case 1:  str = "/anonymous/verify/code1"
                default: str = "/anonymous/verify/code2"
                }
                return (str, params)
            
            case .addComment(let id, let content):
                params = ["goodID": id, "content": content]
                return ("/normal/comment/addComment", params)
            
            case .changePic:
                return ("/normal/user/changePic", params)
            
            
            }
        }()
        
        let url = try Router.baseUrlStr.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
        return try URLEncoding.default.encode(urlRequest, with: result.para)
    }
    
    static func getPicURL(_ id: Int) -> URL {
        return URL(string: "http://139.199.39.220/img/\(id)/portrait.png")!
    }

}








