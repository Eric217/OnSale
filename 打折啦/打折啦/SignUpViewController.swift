//
//  SignUpViewController.swift
//  打折啦
//
//  Created by Eric on 7/23/17.
//  Copyright © 2017 INGStudio. All rights reserved.
//


import Foundation
import UIKit
import SnapKit


//TODO: - 为什么观察者没用呢？必须用通知？通知还报错？？烦
class PhoneNumberController: SignUpBaseViewController {
    
    let ph1 = "输入手机号码"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fd_prefersNavigationBarHidden = true

        addNextLabel()
        
        labelTitle = UILabel()
        textField1?.keyboardType = .numberPad
        textField1?.placeholder = ph1
        textField1?.addTitleLabel(labelTitle!)
        textField1?.becomeFirstResponder()

        
        setupAttributeLabel()
        
        
        
    }
    
    func setupAttributeLabel() {
        bottomLabel = UILabel()
        view.addSubview(bottomLabel!)
        bottomLabel?.snp.makeConstraints{ make in
            make.height.equalTo(20)
            make.width.equalTo(ScreenWidth-50)
            make.bottom.equalTo(-10-numBoardSmall)
            make.centerX.equalTo(ScreenWidth/2)
        }
        let str1 = "已阅读并同意使用条款和隐私政策"
        let str1len = str1.len()
        let attStr = NSMutableAttributedString(string: str1)
        
        attStr.addAttribute(NSFontAttributeName, value: Config.themeFont(12), range: myRange(0,str1len))
        attStr.addAttribute(NSForegroundColorAttributeName, value: Config.themeGray, range: myRange(0,6))
        attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: myRange(6, 4))
        attStr.addAttribute(NSForegroundColorAttributeName, value: Config.themeGray, range: myRange(10, 1))
        attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: myRange(11, 4))
        
        bottomLabel?.attributedText = attStr
        bottomLabel?.textAlignment = .center
        bottomLabel?.yb_addAttributeTapAction(["使用条款","隐私政策"]){
            (str, range, int) in
            self.navigationController?.pushViewController(WebViewController(), animated: true)
        }
    }
    
    override func nxt(_ label: UILabel) {
        
        print("nxt func invoked")
        let codeController = CodeVerifyController()
        navigationController?.pushViewController(codeController, animated: true)
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.len() == 11 {
            nextLabel?.setBackgroundImage(named: "next")
            return false
        }
        return true
    }

    
    @objc func valueChanged() {
        
        print("valueChanged func invoked")
        let txtLen = textField1?.text!.len()
        labelTitle?.text = txtLen == 0 ? "" : ph1
    }
    
 
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(valueChanged), name: .UITextFieldTextDidChange, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .UITextFieldTextDidChange, object: nil)
    }

    
}

class CodeVerifyController: SignUpBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true
        
        
        
    }
    
}
class WebViewController: UIViewController {
    
    lazy var webView = { return UIWebView() }()
    override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true
        webView.loadRequest(URLRequest(url: URL(string: "https://baidu.com")!))
        view.addSubview(webView)
        webView.snp.makeConstraints{ make in
            make.size.centerX.equalTo(view)
        }
        
    }
   
    
}

class SignUpBaseViewController: UIViewController {
    
    var labelTitle: UILabel?
    var textField1: UITextField?
    var labelSubtitle: UILabel?
    var nextLabel: UIView?
    var bottomLabel: UILabel?
    var backButton: UIButton?
    var textField2: UITextField?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        //
        view.setBackgroundImage(named: "unknown")
        
        
        backButton = UIButton()
        backButton?.setBackgroundImage(UIImage(named: "back"), for: .normal)
//        backButton?.setTitle("返回", for: .normal)
        backButton?.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(backButton!)
        backButton?.snp.makeConstraints{ make in
            make.left.equalTo(10)
            make.top.equalTo(40)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        let r:CGFloat = 57
        
        textField1 = UITextField()
        textField1?.clearButtonMode = .whileEditing
        textField1?.textAlignment = .center
        textField1?.font = Config.themeFont(21)
        textField1?.delegate = self
        view.addSubview(textField1!)
        textField1?.addConstraintY(centerY: ScreenHeight/2 - numBoardSmall/2, right: r)
        textField1?.addBottomLine(height: 1, color: .lightGray)
        
        
    }
    
    
    func addNextLabel() {
        nextLabel = UIView()
        nextLabel?.setBackgroundImage(named: "next_1")
        let gesture = UITapGestureRecognizer(target: self, action: #selector(nxt))
        nextLabel?.addGestureRecognizer(gesture)
        view.addSubview(nextLabel!)
        nextLabel?.snp.makeConstraints{ make in
            make.right.equalTo(textField1!)
            make.bottom.equalTo(-numBoardSmall - 70)
            make.size.equalTo(38)
        }
        

    }
    
    
    func nxt(_ label: UILabel) {
        
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension SignUpBaseViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
}







