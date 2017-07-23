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

class SignInViewController: UIViewController {
    
    var headImgView: UIImageView!
    var accountField: UITextField!
    var psdField: UITextField!
    var newButton: UIButton!
    var forgetButton: UIButton!
    var loginButton: UIButton!
    var mark1:UIView!
    
    var myConstraint:Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let height: CGFloat = 44
        let left1: CGFloat = 60
        let left2: CGFloat = 100
        let left3: CGFloat = 10
        let width1: CGFloat = 70
        let height1: CGFloat = 18
        
        let rad: CGFloat = 45
        let lineH: CGFloat = 0.6
        let distance: CGFloat = 50
    
        let top: CGFloat = 80
        
///
        headImgView = UIImageView()
        headImgView.layer.cornerRadius = rad
        headImgView.layer.masksToBounds = true
        headImgView.image = UIImage(named: "placeholder_0")
        view.addSubview(headImgView)
        headImgView.snp.makeConstraints{ (make) in
            make.width.height.equalTo(rad*2)
            make.centerX.equalTo(view)
            make.top.equalTo(top)
        }
        
///以 headImgView 位置为参考
        accountField = UITextField()
        //let leftView1 = UIView(frame: myRect(0,0,height,height))
        //leftView1.setBackgroundImage(named: "placeholder_0")
        //accountField.leftView = leftView1
        //accountField.leftViewMode = .always
        accountField.placeholder = "手机/会员名/邮箱"
        accountField.clearButtonMode = .whileEditing
        accountField.tag = 200
        accountField.textAlignment = .center
        view.addSubview(accountField)
        accountField.snp.makeConstraints{ (make) in
            make.height.equalTo(height)
            make.left.equalTo(left1)
            make.right.equalTo(-left1)
            make.top.equalTo(headImgView.snp.bottom).offset(distance)
        }
        mark1 = UIView(frame: myRect(0, 0, height, height))
        mark1.setBackgroundImage(named: "12345")
        accountField.rightView = mark1
        accountField.rightViewMode = .whileEditing
        
        let separator1 = UIView()
        separator1.backgroundColor = UIColor.lightGray
        accountField.addSubview(separator1)
        separator1.snp.makeConstraints{ (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(accountField)
            make.height.equalTo(lineH)
        }
/// 以 accountField 为参考
        psdField = UITextField()
        //let leftView2 = UIView(frame: myRect(0,0,height,height))
        //leftView2.setBackgroundImage(named: "placeholder_1")
        //psdField.leftView = leftView2
        //psdField.leftViewMode = .always
        psdField.psdMod()
        psdField.textAlignment = .center
        psdField.tag = 201
        view.addSubview(psdField)
        psdField.snp.makeConstraints{ (make) in
            make.top.equalTo(accountField.snp.bottom)
            make.size.centerX.equalTo(accountField)
        }
        let separator2 = UIView()
        separator2.backgroundColor = UIColor.lightGray
        psdField.addSubview(separator2)
        separator2.snp.makeConstraints{ (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(psdField)
            make.height.equalTo(lineH)
        }
/// 以 psdField 为参考
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
            make.top.equalTo(psdField.snp.bottom).offset(height)
        }
/// 以屏幕参考
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        accountField.resignFirstResponder()
        psdField.resignFirstResponder()
    }
    
//    override func updateViewConstraints() {
//        
//        super.updateViewConstraints()
//    }
    @objc func login(_ button: UIButton) {

        print(123)
       
        
    }
    
    @objc func changeAccount() {
        
    }
    
    @objc func new(_ button: UIButton) {
        print(234)
    }
    
    @objc func forget(_ button: UIButton) {
        print(2356)
        
    }

}
extension SignInViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     
        
        
        return false
    }
    
}







