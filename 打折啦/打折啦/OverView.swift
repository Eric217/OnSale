//
//  OverView.swift
//  打折啦
//
//  Created by Eric on 25/08/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
extension OverViewController {
    
    func setupChild() {
        
//        let re = UIViewController()
//        re.view.backgroundColor = .gray
        //searchController = UISearchController(searchResultsController: re)
        //searchController.view.backgroundColor = UIColor.lightGray
        
    }
    
    
    
    func setupCollection() {
        
        
        
    }
    
    func setupBar() {
        
        /*
        belowLayer = CAGradientLayer()
        belowLayer.zPosition = -1
        belowLayer.setBack(Config.themeColor)
        belowLayer.frame = myRect(0, -20, ScreenWidth, 64)
        belowLayer.startPoint = CGPoint(x: 0, y: 0.5)
        belowLayer.endPoint = CGPoint(x: 1, y: 0.5)
        navigationController?.navigationBar.layer.addSublayer(belowLayer)
        
        navBarShadowImageHidden = true
        navBarBackgroundAlpha = 0
        navBarTintColor = UIColor.white
        
        let rightItem = UIBarButtonItem(image: #imageLiteral(resourceName: "moretype"), style: .plain, target: self, action: #selector(chooseType))
        navigationItem.rightBarButtonItem = rightItem
        let leftItem = UIBarButtonItem(image: #imageLiteral(resourceName: "code"), style: .plain, target: self, action: #selector(scan))
        navigationItem.leftBarButtonItem = leftItem
    */
        view.backgroundColor = UIColor.groupTableViewBackground
        
        navBar = ELSearchNavBar()
        navBar.setBackColor(Config.themeColor)
        navBar.setLeftRightImage(left: "code", right: "moretype")
        fd_prefersNavigationBarHidden = true
        navBar.search.delegate = self
        navBar.setButton.addTarget(self, action: #selector(scan), for: .touchUpInside)
        navBar.codeButton.addTarget(self, action: #selector(chooseType), for: .touchUpInside)
        view.addSubview(navBar)

    }
    
    /*
    func setupSearch() {
    
        resultController = MySearchController()
        searchController = UISearchController(searchResultsController: resultController)
        searchController.searchResultsUpdater = resultController
        
        //searchController.hidesNavigationBarDuringPresentation = true
        //searchController.dimsBackgroundDuringPresentation = true
        searchController.definesPresentationContext = true
  
        searchContainer = UISearchContainerViewController(searchController: searchController)
        searchContainer.view.backgroundColor = UIColor.groupTableViewBackground
        searchContainer.searchController.obscuresBackgroundDuringPresentation = true
 
    }
    */

    
    
    @objc func chooseType() {
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //navBar.search.resignFirstResponder()
    }
    
    @objc func search() {
        
        
       
        //present(searchController, animated: true, completion: nil)
    }
    
    @objc func scan() {
   
        
        
    }
    
    
    
}













