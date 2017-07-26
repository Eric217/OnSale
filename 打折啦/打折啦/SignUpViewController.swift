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

class SignUpBaseViewController: UIViewController {
    
    var labelTitle: UILabel?
    var textField: UITextField?
    var labelSubtitle: UILabel?
    var nextLabel: UIButton?
    var bottomLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.setBackgroundImage(named: "unknown")
        nextLabel?.setBackgroundImage(UIImage(named: "✔"), for: .normal)
       
        
    }
    
    
}
