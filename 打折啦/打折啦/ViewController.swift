//
//  ViewController.swift
//  打折啦
//
//  Created by Eric on 7/18/17.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import UIKit

import ESTabBarController_swift


class ViewController: ESTabBarController {
   
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    
   
    
    var nav1:UINavigationController!
    var nav2:UIViewController!
    var nav3:UIViewController!
    var nav4:UINavigationController!
    var nav5:UINavigationController!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate = nil
        
        tabBar.shadowImage = UIImage(named: "transparent")
        //tabBar.backgroundImage = UIImage(named: "background_dark")
        
        shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        
        didHijackHandler = {
            [weak self] tabbarController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self?.present(UpLoadViewController(), animated: true, completion: nil)
            }
        }
        
        initControllers()
        
        
    }
    
    
    
    
    
    func initControllers() {
        
        
        
        nav1 = UINavigationController(rootViewController: OverViewController())
        nav2 = MapViewController()
        nav3 = UIViewController()
        nav4 = UINavigationController(rootViewController: ServiceViewController())
        nav5 = UINavigationController(rootViewController: PersonViewController())
        
        
        nav1.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "OverView", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        nav2.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Around", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        nav3.tabBarItem = ESTabBarItem.init(ExampleIrregularityContentView(), title: "  ", image: UIImage(named: "photo_verybig"), selectedImage: UIImage(named: "photo_verybig"))
        nav4.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Service", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        nav5.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Me", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        
        
        let arr = [nav1, nav2, nav3, nav4, nav5] as! [UIViewController]
        viewControllers = arr
        
        
    }
    
    
    
    
    
    
    
    
}



