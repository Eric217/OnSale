//
//  ModifyBaseController.swift
//  打折啦
//
//  Created by Eric on 05/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
import Alamofire

class ModifyBaseController: ELPushedController {
    
    var delegate: ValueRecaller?
    ///0: title, 1: content
    var content: (String, String)!
    var destination: String!
    
    var textf: UITextField?
    var textv: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
       
        
        addBar(content.0, rightText: "完成")
    }
    
    func initWhich(textf: Bool) {
        
        
        
    }
    
    
}







