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

class OverViewController: UIViewController {
    
    var refreshHeader: MJRefreshHeader!
    var refreshFooter: MJRefreshAutoNormalFooter!
    var belowLayer: CAGradientLayer!
    
    //var scroll: UIScrollView!
    var navBar: ELSearchNavBar!
    
    var resultController: MySearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshHeader = MJRefreshNormalHeader {
            
        }
        refreshFooter = MJRefreshAutoNormalFooter {
            
        }
        
        //setupSearch()
        setupChild()
        setupCollection()
        setupBar()
//        let iv = UIImageView()
//        iv.kf.setImage(with: , placeholder: , options: , progressBlock: , completionHandler: )
//        iv.kf.setImage(with: URL(string: " "), placeholder: UIImage())
//        let proce = BlurImageProcessor(blurRadius: 4) >> RoundCornerImageProcessor(cornerRadius: 4)
//
        
    }
   
    
    func loadData() {
         
    }
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }



}
extension OverViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        pushWithoutTab(MySearchController(""), animated: false)
        return false
    }
}







