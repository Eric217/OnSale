//
//  NameVerifyController.swift
//  打折啦
//
//  Created by Eric on 8/4/17.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
import Alamofire

class NameVerifyController: SignUpBaseViewController {
    
    let plhd0 = "昵称格式不正确"
    let plhd2 = "密码格式不正确"
    
    var phone = ""
    let titleSize:CGFloat = 16
    ///第二个输入框
    var textField2: UITextField?
    lazy var labelTitle2 = UILabel()
    
    var con1 = false{
        didSet{
            nxtValid = con1&&con2
        }
    }
    var con2 = false{
        didSet{
            nxtValid = con1&&con2
        }
    }
    var con3 = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let inset:CGFloat = 30
        addMainConstraint(tf: ScreenHeight/2 - numBoardSmall/2 - inset, nxt: 45)
        textField1?.placeholder = ph3
        textField2 = UITextField()
        textField2?.clearButtonMode = .whileEditing
        textField2?.textAlignment = .center
        textField2?.font = Config.themeFont(21)
        textField1?.returnKeyType = .next
        textField2?.returnKeyType = .go
        textField2?.delegate = self
        textField2?.placeholder = ph4
        view.addSubview(textField2!)
        textField2?.snp.makeConstraints{ make in
            make.height.equalTo(45)
            make.left.equalTo(right)
            make.right.equalTo(-right)
            make.top.equalTo(textField1!.snp.bottom).offset(10)
        }
        textField2?.addBottomLine(height: 1)
        textField2?.keyboardType = .asciiCapable
        textField2?.autocorrectionType = .no
        //其他初始化
        labelTitle = UILabel()
        textField1?.addTitleLabel(labelTitle!, titleSize)
        textField2?.addTitleLabel(labelTitle2, titleSize)
        labelTitle2.textColor = Config.themeGray.withAlphaComponent(0)
        
    }
    
    ///对tf1 的监听
    @objc override func valueChanged() {
        labelTitle?.text = ph3
        let txtLen = textField1!.text!.len()
        labelTitle?.textColor = txtLen == 0 ?
            UIColor.clear : Config.themeGray
        
    }
    ///对tf2 的监听
    @objc func valueChanged2() {
        labelTitle2.text = "请设置8-16位密码"
        let txtLen = textField2!.text!.len()
        if txtLen == 0 {
            unDrag(duration: 0.2)
        }else {
            drag(duration: 0.2)
        }
        
    }
    ///下移动画
    func drag(duration: Double, _ color: UIColor = Config.themeGray) {
        
        UIView.animate(withDuration: duration, animations: {
            self.textField2?.snp.updateConstraints{ make in
                make.top.equalTo(self.textField1!.snp.bottom).offset(30)
                self.labelTitle2.textColor = color.withAlphaComponent(1)
            }
            self.view.layoutIfNeeded()
        })
    }
    func unDrag(duration: Double) {
        
        UIView.animate(withDuration: duration, animations: {
            self.textField2?.snp.updateConstraints{ make in
                make.top.equalTo(self.textField1!.snp.bottom).offset(10)
                self.labelTitle2.textColor = Config.themeGray.withAlphaComponent(0)
            }
            self.view.layoutIfNeeded()
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case textField1!: textField2!.becomeFirstResponder()
        case textField2!: nxt()
        default: break
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case textField1!: validateForm(1, (textField1?.text)!)
        case textField2!: validateForm(2, (textField2?.text)!)
        default: break
        }
    }
    ///1账号，2是密码
    func validateForm(_ type: Int, _ content: String) {
        guard type == 1 else {
            //密码正则：
            guard Config.predicate(Regex.pswd, content) else{
                warn(2, plhd2)
                con2 = false
                return
            }
            con2 = true
            return
        }
        //账号正则：
        guard Config.predicate(Regex.name, content) else {
            warn(1, plhd0)
            con1 = false
            return
        }
        con1 = true
        con3 = false
        Alamofire.request(Router.validate(Property.nickName, content)).validate()
            .responseJSON{ response in
                switch response.result {
                case .failure(let error):
                    print(dk, error)
                    hud.showError(withStatus: "网络连接失败")
                case .success(let value):
                    if ((value as! NSDictionary)["data"] as! Bool) {
                        self.con3 = false
                        self.warn(1, self.ph03); return
                    }
                    self.con3 = true
                }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    
    @objc override func nxt() {
        view.endEditing(true)
        let name = (textField1?.text)!
        let psd = (textField2?.text)!
        guard name != "" else{
            warn(1, "昵称不能为空")
            return
        }
        guard psd != "" else {
            warn(2, "密码不能为空")
            return
        }
        guard nxtValid else { return }
        
        if con3 {
            signUp(phone, name: name, psd: psd)
        }else{
            Alamofire.request(Router.validate(Property.nickName, name)).validate()
                .responseJSON{ response in
                    
                    switch response.result {
                    case .failure(let error):
                        print(dk, error)
                        hud.showError(withStatus: "网络连接失败")
                    case .success(let value):
                        if ((value as! NSDictionary)["data"] as! Bool) {
                            self.con3 = false
                            self.warn(1, self.ph03); return
                        }
                        self.con3 = true
                        self.signUp(self.phone, name: name, psd: psd)
                    }
            }
        }
    }
    
    func signUp(_ ph: String, name: String, psd: String) {
        Alamofire.request(Router.signUp(ph, name, psd)).validate()
            .responseJSON{ response in
                switch response.result {
                case .failure(let e):
                    print("my error: ", e)
                case .success:
                    hud.show(withStatus: "注册成功，正在登录")
                    self.signIn(name, psd)
                }
        }
    }
    
    func signIn(_ name: String, _ psd: String) {
        Alamofire.request(Router.signIn(Property.nickName, name, psd: psd)).validate()
            .responseJSON{ response in
                switch response.result {
                case .failure(let e):
                    print(dk,e)
                case .success(let value):
                    guard let info = value as? NSDictionary else {
                        print("SignIn_JSON_ERROR"); return
                    }
                    let person = Person(save: true)
                    person.analyse(info)
                    userDefau.saveBasic(true, key: isSignedKey)
                    hud.showSuccess(withStatus: "登陆成功")
                    
                    let abc = self.navigationController?.presentingViewController
                    self.navigationController?.dismiss(animated: true){
                        if abc!.isKind(of: ViewController.self) {
                            print("selectedIndex changed after dismission")
                            (abc as! ESTabBarController).selectedIndex = 4
                        }
                    }
                    
                }
                
        }
    }
    
    func warn(_ tf: Int, _ content: String) {
        if tf == 1 {
            labelTitle?.text = content
            labelTitle?.textColor = .red
        }else{
            labelTitle2.text = content
            labelTitle2.textColor = .red
            if textField2?.text == "" {
                drag(duration: 0.2, .red)
            }
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(valueChanged2), name: .UITextFieldTextDidChange, object: textField2)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .UITextFieldTextDidChange, object: textField2)
    }
    
}




