//
//  TypeChoose.swift
//  打折啦
//
//  Created by Eric on 31/08/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation

enum ValueType {
    static let location = "location"
    static let kind = "kind"
}

protocol ValueRecaller {
    func transferLocation(_ value: [Any])
    func transferType(_ value: String, position: Int)
}

extension Identifier {
    static let typechooseCellId = "dasdfqeas"
    static let locachooseCellId = "loscafsefs"
}

class TypeChooser : ELPushedController, UITableViewDataSource, UITableViewDelegate {
    
    var delegate: ValueRecaller?
    var table: UITableView!
    var dataArr: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table = UITableView(frame: CGRect(x: 0, y: 44, width: ScreenWidth, height: ScreenHeight - 44), style: .plain)
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: Identifier.typechooseCellId)
        table.separatorColor = UIColor.lightGray.withAlphaComponent(0.85)
        table.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(table)
        addBar("选择种类")
        
        let path = Bundle.main.path(forResource: "ItemType", ofType: "plist")
        dataArr = NSArray(contentsOfFile: path!) as? [String]
        
        
    }
    
    //MARK: - delegate and data source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.typechooseCellId)
        cell?.textLabel?.textColor = UIColor.darkGray
        cell?.textLabel?.text = " "+dataArr[indexPath.row]
        cell?.backgroundColor = UIColor.white
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let r = indexPath.row
        delegate?.transferType(dataArr[r], position: r)
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}


