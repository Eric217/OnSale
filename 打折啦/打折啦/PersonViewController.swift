//
//  PersonViewController.swift
//  frame
//
//  Created by Eric on 7/14/17.
//  Copyright © 2017 Eric. All rights reserved.
//

import Foundation
import UIKit
class PersonViewController: UIViewController {
    
    var tableView:UITableView!
    var v:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Me"
  
    
       
        
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        v = UIImageView(frame: CGRect(x: 0, y: -200, width: view.bounds.width, height: 200))
        v?.image = UIImage()
        v?.contentMode = .scaleAspectFill
        v?.clipsToBounds = true
        
        tableView.contentInset = UIEdgeInsets(top: 200-64, left: 0, bottom: 0, right: 0)
        tableView.addSubview(v!)

        
        
        view.addSubview(tableView)
        
    }
    
    
    
    
}

extension PersonViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return 48
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
       
        return " "
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 35
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        
    }
    
}








