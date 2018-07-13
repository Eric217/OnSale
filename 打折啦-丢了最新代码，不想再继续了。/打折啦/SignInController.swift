//
//  SigninViewController.swift
//  Application
//
//  Created by Eric on 7/20/17.
//  Copyright © 2017 Eric. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Alamofire

var currentKey = "currentKey"
var currentIDKey = "currenIDKey"

typealias hud = SVProgressHUD
let offline = "The Internet connection appears to be offline"

class SignInViewController: UIViewController {
    
    var headImgView: UIImageView!
    var accountField: UITextField!
    var forgetButton: UIButton!
    var loginButton: UIButton!
    var psdField: UITextField!
    var newButton: UIButton!
    var mark1:UIView!
    var cancelButton: UIButton!
    var bottomLabel: UILabel!
    
    ///整体
    var headConstr:Constraint?
    ///头像下方
    var txtfConstr:Constraint?
    ///登陆按钮上方
    var signConstr:Constraint?
    
    let standard: CGFloat = 0.35
    let distance: CGFloat = 50
    let height2: CGFloat = 39
    let top: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
     
    }
    //TODO: - 选择账号
    func showAccounts() {
        
    }
    
    
    func cancel() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        endEditing()
    }

    
    func myDismiss() {
        let abc = navigationController?.presentingViewController as? ViewController
        navigationController?.dismiss(animated: true) {
            guard abc != nil else { return }
            //let toselect = abc!.toSelectIndex
            //abc?.selectedViewController = abc!.viewControllers?[toselect]
           
            abc?.selectedIndex = 4
            hud.show()           
        }
    }
    
    
    @objc func login(_ button: UIButton) {
        
        #if DEBUG
            let me = Person(save: true)
            me.id = 10
            me.phone = "13176370907"
            me.nickName = "Catherine1323224"
            me.psd = "12345754323"
            me.gender = "男"
            me.mark = 100
            me.type = 1
            me.signature = "wocao???"
            me.realName = ""
            me.realID = ""
            me.email = ""
            me.birthday = "1901-01-01"
            me.fans = 0
            userDefau.saveBasic(true, key: isSignedKey)
            me.analyse([:])
            myDismiss()
            return
        #endif
        
        endEditing()
        let account = accountField.text
        let passd = psdField.text
        let psdLen = passd!.len()
        hud.setMinimumDismissTimeInterval(0.5)
        if account == "" {
            hud.showError(withStatus: "请输入账号"); return
        }
        if account!.contains(" ") || account!.len() >= 30 {
            hud.showError(withStatus: "账号输入错误"); return
        }
        if passd == "" {
            hud.showError(withStatus: "请输入密码"); return
        }
        if passd!.contains(" ") || psdLen < 8 || psdLen > 16 {
            hud.showError(withStatus: "密码错误"); return
        }
        hud.show(withStatus: "正在登录")
        //下面三步走
        valiPhone(account!, passd!)

    }
    
    func valiPhone(_ account: String, _ psd: String) {
        Alamofire.request(Router.signIn(Property.phone, account, psd: psd)).validate()
            .responseJSON{ response in
                switch response.result {
                case .success(let value):
                    self.success(value)
                case .failure(let error):
                    print(dk,error)
                    self.valiName(account, psd)
                }
        }
    }
    func valiName(_ account: String, _ psd: String) {
        Alamofire.request(Router.signIn(Property.nickName, account, psd: psd)).validate()
            .responseJSON{ response in
                switch response.result {
                case .success(let value):
                    self.success(value)
                case .failure(let error):
                    print(dk,error)
                    self.valiEmail(account, psd)
                }
        }
    }
    func valiEmail(_ account: String, _ psd: String) {
        Alamofire.request(Router.signIn(Property.email, account, psd: psd)).validate()
            .responseJSON{ response in
                switch response.result {
                case .success(let value):
                    self.success(value)
                case .failure(let error):
                    print(dk,error)
                    if "\(error)".contains(offline) {
                        hud.showError(withStatus: "网络连接超时")
                    }
                    hud.showError(withStatus: "账号或密码错误")
                }
        }
    }
    func success(_ value: Any) {
        guard let info = value as? NSDictionary else {
            print("SignIn_JSON_ERROR"); return
        }
        
        let person = Person(save: true)
        person.analyse(info)
        
        userDefau.saveBasic(true, key: isSignedKey)
        hud.showSuccess(withStatus: "登陆成功")
        
        myDismiss()
    }
    
    @objc func phoneSign() {
        navigationController?.pushViewController(PhoneSignInController(), animated: true)
    }
    
    @objc func find() {
        navigationController?.pushViewController(ResetPsdController(), animated: true)
    }
    
    @objc func changeAccount() {
        
    }
    
    @objc func new(_ button: UIButton) {
        navigationController?.pushViewController(PhoneNumberController(), animated: true)
        
    }
    
    @objc func forget(_ button: UIButton) {
        
        
        let alertControl = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let find = UIAlertAction(title: "找回密码", style: .default, handler: { (alert) in self.find() })
        let phoneLog = UIAlertAction(title: "短信验证登陆", style: .default, handler: { (alert) in self.phoneSign() })
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alertControl.addAction(phoneLog)
        alertControl.addAction(find)
        alertControl.addAction(cancel)
        
        present(alertControl, animated: true, completion: nil)
        
    }

    ///change top constraint animatedly
    ///Param isBack: 1 indicating normal or 2 inputing
    func change(by times: CGFloat, duration seconds: Double) {
 
        UIView.animate(withDuration: seconds, animations: {
        
            self.headConstr?.update(offset: ScreenHeight*self.standard*0.5/times.squareRoot().squareRoot())
            self.txtfConstr?.update(offset: ScreenHeight*self.standard/times.squareRoot())
            self.signConstr?.update(offset: self.height2/times)
            self.view.layoutIfNeeded()
            
       
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        endEditing()
    }
    
    func endEditing() {
        view.endEditing(true)
        change(by: 1, duration: 0.2)
    }
    
}

class PhoneSignInController: PhoneNumberController {
    
    override func nxt() {
        let txt = textField1!.text!
        guard textField1?.text?.len() == 11 && nxtValid else {
            labelSubtitle?.text = ph00
            return
        }
        guard Config.predicate(Regex.phone, txt) else {
            labelSubtitle?.text = "请输入正确的手机号"
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
                        self.sendCode(of: txt, to: CodeSignInController())
                        return
                    }
                    self.showTips()
                }
        }
    }

    override func showTips() {
        let ph = textField1!.text!
        let alertControl = UIAlertController(title: "提示", message: "该手机号尚未注册，是否立即注册？", preferredStyle: .alert)
        let phoneLog = UIAlertAction(title: "确定", style: .default, handler: { (alert) in
            hud.show()
            Alamofire.request(Router.verify(3, value: ph)).validate()
                .responseJSON{ response in
                    switch response.result {
                    case .failure(let error):
                        print(dk, error)
                        hud.showError(withStatus: "网络连接失败")
                    case .success:
                        hud.showSuccess(withStatus: "验证码已发送")
                        let controller = CodeVerifyController()
                        controller.phone = ph
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
            }

        })
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertControl.addAction(phoneLog)
        alertControl.addAction(cancel)
        present(alertControl, animated: true, completion: nil)
    }
    
}


class CodeSignInController: CodeVerifyController {
    
    override func nxt() {
        guard nxtValid else { return }
        hud.show()
        Alamofire.request(Router.verify(2, value: phone)).validate()
            .responseJSON{ response in
                switch response.result {
                case .failure(let error):
                    print(dk, error)
                    hud.showError(withStatus: "验证码错误，请重新发送")
                case .success(let value):
                    self.success(value: value)
                }
        }

    }
    func success(value: Any) {
        hud.show(withStatus: "验证成功，正在登录")
        guard let info = value as? NSDictionary else {
            print(dk, "js"); return
        }
        let person = Person(save: true)
        person.analyse(info)
        userDefau.saveBasic(true, key: isSignedKey)
        hud.showSuccess(withStatus: "登陆成功")
        
        let abc = navigationController?.presentingViewController
        navigationController?.dismiss(animated: true){
            if abc!.isKind(of: ViewController.self) {
                print("selectedIndex changed after dismission")
                (abc as! ESTabBarController).selectedIndex = 4
            }
        }

    }
    
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        change(by: 1.8, duration: 0.3)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 200:
            psdField.becomeFirstResponder()
        case 201:
            login(loginButton)
        default:
            break
        }
        return true
    }
    
   
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField == accountField {
            psdField.text = ""
        }
        return true
    }
    
}



