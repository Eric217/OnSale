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

extension Str {    //static let plhd_1 = "手机/会员名/邮箱"
    
}

class SignInViewController: UIViewController {
    
    var headImgView: UIImageView!
    var accountField: UITextField!
    var forgetButton: UIButton!
    var loginButton: UIButton!
    var psdField: UITextField!
    var newButton: UIButton!
    var mark1:UIView!
    
    ///整体
    var headConstr:Constraint?
    ///头像下方
    var txtfConstr:Constraint?
    ///登陆按钮上方
    var signConstr:Constraint?
    
    let distance: CGFloat = 50
    let height2:CGFloat = 50
    let top: CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let height: CGFloat = 45
        ///txtfd
        let left1: CGFloat = 60
        ///login
        let left2: CGFloat = 85
        ///bottom
        let left3: CGFloat = 10
        
        let width1: CGFloat = 70
        let height1: CGFloat = 18
        let rad: CGFloat = 45
        let lineH: CGFloat = 0.6
        let font = Config.themeFont(21)
        
//MARK: - setup view:

        fd_prefersNavigationBarHidden = true
        view.backgroundColor = UIColor.white
        
        
        headImgView = UIImageView()
        headImgView.layer.cornerRadius = rad
        headImgView.layer.masksToBounds = true
        headImgView.image = UIImage(named: "placeholder_0")
        view.addSubview(headImgView)
        headImgView.snp.makeConstraints{ (make) in
            make.width.height.equalTo(rad*2)
            make.centerX.equalTo(view)
            headConstr = make.top.equalTo(top).constraint
        }
        
//以 headImgView 位置为参考
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
            txtfConstr = make.top.equalTo(headImgView.snp.bottom).offset(distance).constraint
        }
        
        mark1 = UIView()
        mark1.setBackgroundImage(named: "point")

        accountField.addRightView(mark1)
        accountField.addBottomLine(height: lineH, color: Config.themeGray)
        
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

//以 psdField 为参考
        loginButton = UIButton(type: .roundedRect)
        loginButton.setTitle("登陆", for: .normal)
        loginButton.backgroundColor = Config.themeColor
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints{ (make) in
            make.left.equalTo(left2)
            make.right.equalTo(-left2)
            make.height.equalTo(40)
            signConstr = make.top.equalTo(psdField.snp.bottom).offset(height2).constraint
        }
//以屏幕参考
        newButton = UIButton()
        newButton.setTitle("新用户注册", for: .normal)
        newButton.setTitleColor(UIColor.blue, for: .normal)
        newButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        newButton.addTarget(self, action: #selector(new), for: .touchUpInside)
        view.addSubview(newButton)
        newButton.snp.makeConstraints{ make in
            make.left.equalTo(left3)
            make.bottom.equalTo(-left3)
            make.height.equalTo(height1)
            make.width.equalTo(width1)
        }
        
        forgetButton = UIButton()
        forgetButton.setTitle("无法登陆?", for: .normal)
        forgetButton.setTitleColor(UIColor.blue, for: .normal)
        forgetButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        forgetButton.titleLabel?.textAlignment = .right
        forgetButton.addTarget(self, action: #selector(forget), for: .touchUpInside)
        view.addSubview(forgetButton)
        forgetButton.snp.makeConstraints{ make in
            make.bottom.right.equalTo(-left3)
            make.height.equalTo(height1)
            make.width.equalTo(width1)
        }
        
        
        
    }
    
    func setupAlert(){
      
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        view.endEditing(true)

        change(by: 1, duration: 0.2)
    }

    
    @objc func login(_ button: UIButton) {
        view.endEditing(true)
        
        change(by: 1, duration: 0.2)
        
    }
    
    
    @objc func phoneSign() {
        
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
        
            self.headConstr?.update(offset: self.top/times)
            self.txtfConstr?.update(offset: self.distance/times)
            self.signConstr?.update(offset: self.height2/times)
            self.view.layoutIfNeeded()
       
        })
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     
        
        return true
    }
    
    
}



