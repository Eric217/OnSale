//
//  OverViewController.swift
//  frame
//
//  Created by Eric on 7/14/17.
//  Copyright © 2017 Eric. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import MJRefresh
import Kingfisher

class OverViewController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "OverView"
        navBarBackgroundImage = UIImage(named: "2")
        statusBarStyle = .lightContent
//        Alamofire.request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)
//        
//        Alamofire.upload(<#T##data: Data##Data#>, with: <#T##URLRequestConvertible#>)
        let iv = UIImageView()
        iv.kf.setImage(with: <#T##Resource?#>, placeholder: <#T##Image?#>, options: <#T##KingfisherOptionsInfo?#>, progressBlock: <#T##DownloadProgressBlock?##DownloadProgressBlock?##(Int64, Int64) -> ()#>, completionHandler: <#T##CompletionHandler?##CompletionHandler?##(Image?, NSError?, CacheType, URL?) -> ()#>)
        iv.kf.setImage(with: URL(string: " "), placeholder: UIImage())
        let b = UIButton()
        b.kf.setImage(with: <#T##Resource?#>, for: <#T##UIControlState#>)
        let proce = BlurImageProcessor(blurRadius: 4) >> RoundCornerImageProcessor(cornerRadius: 4)
        
    }
    
    
}
