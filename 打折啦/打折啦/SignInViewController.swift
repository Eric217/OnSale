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
import ESTabBarController_swift

var currentID = 0
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
    
    let standard:CGFloat = 0.35
    let distance: CGFloat = 50
    let height2:CGFloat = 39
    let top: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let height: CGFloat = 45
        ///txtfd
        let left1: CGFloat = 44
   
        let width1: CGFloat = 70
        let height1: CGFloat = 18
        let rad: CGFloat = 46
        let lineH: CGFloat = 1
        let font = Config.themeFont(21)
        
//MARK: - setup views of cancel,head

        fd_prefersNavigationBarHidden = true
        view.backgroundColor = UIColor.white
        
        
        cancelButton = UIButton(type: .system)
        cancelButton.setTitle("取消", for: .normal)
        view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        cancelButton.snp.makeConstraints{ make in
            make.right.equalTo(-15)
            make.top.equalTo(25)
        }
        
        
        
//MARK: - setup views of tf1, 展示账户, tf2
//以手机位置为参考
        accountField = UITextField()
        accountField.placeholder = "手机/会员名/邮箱"
        accountField.clearButtonMode = .whileEditing
        accountField.tag = 200
        accountField.textAlignment = .center
        accountField.font = font
        accountField.returnKeyType = .next
        accountField.delegate = self
        view.addSubview(accountField)
        accountField.snp.makeConstraints{ (make) in
            make.height.equalTo(height)
            make.left.equalTo(left1)
            make.right.equalTo(-left1)
            txtfConstr = make.top.equalTo(ScreenHeight*standard).constraint
            //txtfConstr = make.top.equalTo(headImgView.snp.bottom).offset(distance).constraint
        }
        
        if userNumKey != 0 {
            mark1 = UIView()
            mark1.setBackgroundImage(named: "point")
            accountField.addRightView(mark1)
            let tap = UITapGestureRecognizer(target: self, action: #selector(showAccounts))
            mark1.addGestureRecognizer(tap)
        }
        
        accountField.addBottomLine(height: lineH, color: Config.themeGray)
        
        headImgView = UIImageView()
        headImgView.layer.cornerRadius = rad
        headImgView.layer.masksToBounds = true
        headImgView.image = UIImage(named: "placeholder_0")
        view.addSubview(headImgView)
        headImgView.snp.makeConstraints{ (make) in
            make.width.height.equalTo(rad*2)
            make.centerX.equalTo(view)
            headConstr = make.centerY.equalTo(ScreenHeight*standard/2).constraint
        }

//以 accountField 为参考
        psdField = UITextField()
        //let leftView2 = UIView(frame: myRect(0,0,height,height))
        //leftView2.setBackgroundImage(named: "placeholder_1")
        //psdField.leftView = leftView2
        //psdField.leftViewMode = .always
        psdField.psdMod()
        psdField.textAlignment = .center
        psdField.tag = 201
        psdField.font = font
        psdField.delegate = self
        psdField.returnKeyType = .go
        view.addSubview(psdField)
        psdField.snp.makeConstraints{ (make) in
            make.top.equalTo(accountField.snp.bottom)
            make.size.centerX.equalTo(accountField)
        }
        psdField.addBottomLine(height: lineH, color: Config.themeGray)

//MARK: - setup views of login,new,forget
//以 psdField 为参考
        loginButton = UIButton()
        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true
        loginButton.setTitle("登陆", for: .normal)
        loginButton.backgroundColor = Config.themeColor.withAlphaComponent(0.5)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints{ (make) in
            make.left.right.equalTo(accountField)
            make.height.equalTo(39)
            signConstr = make.top.equalTo(psdField.snp.bottom).offset(height2).constraint
        }
//以屏幕参考
        newButton = UIButton()
        newButton.setTitle("新用户注册", for: .normal)
        newButton.setTitleColor(Config.systemBlue, for: .normal)
        newButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        newButton.addTarget(self, action: #selector(new), for: .touchUpInside)
        view.addSubview(newButton)
        newButton.snp.makeConstraints{ make in
            make.left.equalTo(loginButton)
            make.top.equalTo(loginButton.snp.bottom).offset(4)
            make.height.equalTo(height1)
            make.width.equalTo(width1+5)
        }
        
        forgetButton = UIButton()
        forgetButton.setTitle("无法登陆?", for: .normal)
        forgetButton.setTitleColor(Config.systemBlue, for: .normal)
        forgetButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        forgetButton.titleLabel?.textAlignment = .right
        forgetButton.addTarget(self, action: #selector(forget), for: .touchUpInside)
        view.addSubview(forgetButton)
        forgetButton.snp.makeConstraints{ make in
            make.right.equalTo(loginButton)
            make.top.equalTo(loginButton.snp.bottom).offset(4)
            make.height.equalTo(height1)
            make.width.equalTo(width1)
        }
        
        
        
    }
    
    //TODO: - 选择账号
    func showAccounts() {
        
    }
    
    
    func cancel() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        view.endEditing(true)
        
        change(by: 1, duration: 0.2)
    }

    
    @objc func login(_ button: UIButton) {
        view.endEditing(true)
        change(by: 1, duration: 0.2)
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
                    print(myError,error)
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
                    print(myError,error)
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
                    print(myError,error)
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
        userNumKey += 1
        let person = Person(userNumKey)
        person.analyse(info, save: true)
        
        hud.showSuccess(withStatus: "登陆成功")
        navigationController?.dismiss(animated: true){
            if (self.presentingViewController!.isKind(of: ViewController.self)) {
                print("selectedIndex changed after dismission")
                (self.presentingViewController as! ESTabBarController).selectedIndex = 4
            }
        }
    }
    
    @objc func phoneSign() {
        navigationController?.pushViewController(PhoneSignInController(), animated: true)
    }
    
    @objc func find() {
        
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
                    print(myError, error)
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
                        print(myError, error)
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
                    print(myError, error)
                    hud.showError(withStatus: "验证码错误，请重新发送")
                case .success(let value):
                    self.success(value: value)
                }
        }

    }
    func success(value: Any) {
        hud.show(withStatus: "验证成功，正在登录")
        guard let info = value as? NSDictionary else {
            print(myError, "js"); return
        }
        userNumKey += 1
        let person = Person(userNumKey)
        person.analyse(info, save: true)
        
        hud.showSuccess(withStatus: "登陆成功")
        self.navigationController?.dismiss(animated: true){
            if (self.presentingViewController!.isKind(of: ViewController.self)) {
                print("selectedIndex changed after dismission")
                (self.presentingViewController as! ESTabBarController).selectedIndex = 4
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



