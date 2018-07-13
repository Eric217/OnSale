//
//  ResetPsdController.swift
//  打折啦
//
//  Created by Eris on 2017/8/15.
//  Copyright © 2017年 INGStudio. All rights reserved.
//

import Foundation
import Alamofire

class ResetPsdController: SignUpBaseViewController {
    
    let ph = "绑定的邮箱/手机号"
    let plh = "您输入的账号不存在"
    override func viewDidLoad() {
        super.viewDidLoad()
        addMainConstraint()
    
        labelTitle = UILabel()
        textField1?.keyboardType = .emailAddress
        textField1?.placeholder = ph
        textField1?.addTitleLabel(labelTitle!)
        addSubtitle()
    }
    
    
    @objc override func nxt() {
        let txt = textField1!.text!
        guard nxtValid else {
            labelSubtitle?.text = plh; return
        }
        if Config.predicate(Regex.email, txt) {
            
            
  
            return
        }
        
        guard Config.predicate(Regex.phone, txt) else {
            labelSubtitle?.text = plh
            return
        }
        hud.show()
        Alamofire.request(Router.validate(Property.phone, txt)).validate()
            .responseJSON{ response in
                
                switch response.result {
                case .failure(let error):
                    print(dk, error)
                    hud.showError(withStatus: "网络连接失败")
                case .success(let value):
                    if ((value as! NSDictionary)["data"] as! Bool) {
                        //has signed up
                        self.sendCode(of: txt, to: CodeResetPsdController())
                    }else {
                        hud.dismiss()
                        self.labelSubtitle?.text = "该手机号尚未注册"
                    }
                }
                
        }
        
    }
    func sendCode(of phone: String, to controller: CodeVerifyController = CodeVerifyController()) {
        Alamofire.request(Router.verify(3, value: phone)).validate()
            .responseJSON{ response in
                switch response.result {
                case .failure(let error):
                    print(dk, error)
                    hud.showError(withStatus: "网络连接失败")
                case .success:
                    hud.showSuccess(withStatus: "验证码已发送")
                    controller.phone = phone
                    self.navigationController?.pushViewController(controller, animated: true)
                }
        }
    }
    
    
    
    
    

    @objc override func valueChanged() {
        let txtLen = textField1?.text!.len()
        if txtLen == 0 {
            labelTitle?.text = ""
            nxtValid = false
        }else {
            labelTitle?.text = ph
            nxtValid = true
        }
        labelSubtitle?.text = ""
    }
    
}


class CodeResetPsdController: CodeVerifyController {
    
    override func nxt() {
        guard nxtValid else { return }
        hud.show()
        Alamofire.request(Router.verify(1, value: phone)).validate()
            .responseJSON{ response in
                switch response.result {
                case .failure(let error):
                    print(dk, error)
                    hud.showError(withStatus: "验证码错误，请重新发送")
                case .success:
                    let psdController = FinishResetController()
                    psdController.phone = self.phone
                    self.navigationController?.pushViewController(psdController, animated: true)
                }
        }
        
    }
    
    
    
}

class FinishResetController: SignUpBaseViewController {
    
    let ph = "请设置8-16位密码"
    var phone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMainConstraint()
        
        labelTitle = UILabel()
        textField1?.psdMod()
        textField1?.placeholder = ph
        textField1?.addTitleLabel(labelTitle!)
        addSubtitle()
    }
    
   
     @objc override func valueChanged() {
        let txtLen = textField1?.text!.len()
        nxtValid = (txtLen! >= 8)&&(txtLen! <= 16)
        labelTitle?.text = txtLen == 0 ? "" : ph
        labelSubtitle?.text = ""
    }
    
    @objc override func nxt() {
        view.endEditing(true)
        let txt = textField1!.text!
        guard nxtValid else { return }
        guard !txt.contains(" ") else {
            labelSubtitle?.text = "密码中不能含有空格"; return
        }
        hud.show()
        Alamofire.request(Router.userInfo(Property.phone, phone)).validate()
            .responseJSON{ response in
                switch response.result {
                case .failure(let error):
                    print(dk, error)
                    hud.showError(withStatus: "网络连接失败")
                case .success(let value):
                    let d = ((value as! NSDictionary)["data"] as! [String: Any])["id"] as! Int
                    self.change(id: d, property: Property.password, value: txt)
                    
                }
        }
    }
    
    
    private func change(id: Int, property: String, value: Any) {
        Alamofire.request(Router.changeInfo(id, property, value)).validate().responseJSON{
            response in
            
            switch response.result {
            case .failure(let error):
                print(dk, error)
                hud.showError(withStatus: "网络连接失败")
            case .success:
                hud.showSuccess(withStatus: "修改成功")
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            
        }
        
        
    }
    
    
    
    
    
  
    
    
}



















