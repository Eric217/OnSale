//
//  UpLoadViewController.swift
//  Application
//
//  Created by Eric on 7/15/17.
//  Copyright © 2017 Eric. All rights reserved.
//

import Foundation
import UIKit

class UpLoadViewController: UIViewController {
    
    
    var scrollView:UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray
        
        
        
        let view2 = UIScrollView(frame: CGRect(x: 0, y: 30, width: view.bounds.width, height: view.bounds.height))
        view2.backgroundColor = UIColor.white
        
        
        
        let maskPath = UIBezierPath(roundedRect: view2.bounds, byRoundingCorners:
            [UIRectCorner.topRight, UIRectCorner.topLeft], cornerRadii: CGSize(width: 8, height: 8))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view2.bounds
        maskLayer.path = maskPath.cgPath
        
        view2.layer.mask = maskLayer
        
        
        
        
        
        view.addSubview(view2)
        

        view2.isUserInteractionEnabled = true

        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        view2.addGestureRecognizer(gesture)
        
        
        
        
    }
    func onTap(){
        
        dismiss(animated: true, completion: nil)
        
        
    }

}




