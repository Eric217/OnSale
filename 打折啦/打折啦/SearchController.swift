//
//  File.swift
//  打折啦
//
//  Created by Eric on 08/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
let searchHistoryKey = "cahdiuaekvh"
extension Identifier {
    static let resultCellId = "sdbjhbqadva"
}
class MySearchController: UIViewController {
    
    var table: UITableView!
    var navBar: SearchResultNavBar!
    var initText: String!
    
    var clearAll = ["暂无搜索历史", "清空搜索记录"]
    var histArr: [String]!
    var toSearchArr: [String]!
    var isActive = false
   
    init(_ txt: String) {
        super.init(nibName: nil, bundle: nil)
        initText = txt
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        histArr = userDefau.stringArray(forKey: searchHistoryKey)
        toSearchArr = [String]()
        setupTable()
        setupBar()
        navBar.search.becomeFirstResponder()

    }
    
    func setupTable() {
        table = UITableView(frame: myRect(0, 44, ScreenWidth, ScreenHeight-44))
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: Identifier.resultCellId)
        view.addSubview(table)
        table.tableFooterView = UIView()

    }
    
    
    func setupBar() {
        view.backgroundColor = UIColor.groupTableViewBackground
        fd_prefersNavigationBarHidden = true
        navBar = SearchResultNavBar()
        navBar.search.text = initText
        view.addSubview(navBar)
        navBar.search.delegate = self
        navBar.cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
    }
    func addToHistory(_ str: String?) {
        if let idx = histArr.index(of: str!) {
            histArr.remove(at: idx)
        }
        
        histArr.insert(str!, at: histArr.startIndex)
        if histArr.count > (IPHONE6P ? 12 : (IPHONE6 ? 11 : 10)) {
            histArr.removeLast()
        }
        userDefau.saveBasic(histArr, key: searchHistoryKey)
        
    }
    
    @objc func cancel() {
        navigationController?.popViewController(animated: false)
    }
    
//    @objc func valueChanged() {
//        print(1244566543)
//        
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navBar.search.becomeFirstResponder()

        searchBar(navBar.search, textDidChange: "")

    }
  
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
    }
 
    
}
extension MySearchController: UISearchBarDelegate {
    
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        isActive = searchText.len() != 0
        toSearchArr.removeAll()
        if isActive {
            //TODO: - 请求服务器获取提示数据。
            //toSearchArr = ****
            //table.reloadData()
        }
        
        table.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let txt = searchBar.text
        addToHistory(txt)
        push(txt)
    }
    
    
    func push(_ key: String?, animated: Bool = false) {
        
        let vcs = navigationController!.viewControllers
        if vcs[1].isKind(of: ResultController.self) {
            navigationController?.setViewControllers([vcs[0], vcs[2]], animated: false)
            let vcs1 = (vcs[1] as! ResultController)
            if vcs1.keyword == key {
                pushWithoutTab(vcs[1], animated: false); return
            }
        }
        pushWithoutTab(ResultController(key: key), animated: animated)
    }
    
}

extension MySearchController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: Identifier.resultCellId)
        cell.selectionStyle = .none
        cell.textLabel?.frame.origin.x += 10
        if indexPath.section == 1 {
            let cont = AttributedLabel()
            cont.textColor = .darkGray
            cont.font = UIFont.systemFont(ofSize: 16)
            cont.contentAlignment = .center
            cell.contentView.addSubview(cont)
            cont.snp.makeConstraints { make in
                make.center.size.equalTo(cell.contentView)
            }
            if histArr.count == 0 {
                cont.text = clearAll[0]
            }else {
                cont.text = clearAll[1]
            }
            return cell
        }
        let row = indexPath.row
        if isActive {
            if row == toSearchArr.count {
                cell.textLabel?.text = navBar.search.text
            }else {
                cell.textLabel?.text = toSearchArr[row]
            }
        }else {
            cell.textLabel?.text = histArr[row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && histArr.count != 0 {
            histArr = [String]()
            userDefau.saveBasic(histArr, key: searchHistoryKey)
            navBar.search.text = nil
            tableView.reloadData(); return
        }
        if indexPath.section == 0 {
            let _key = tableView.cellForRow(at: indexPath)?.textLabel?.text
            addToHistory(_key)
            push(_key)
            navBar.search.text = _key
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        if isActive {
            return toSearchArr.count + 1
        }
        return  histArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 47
        }
        let h = (ScreenHeight-64)/( IPHONE6 ? 11 : (IPHONE6P ? 12 : 10))
        if h < 50 {
            return 50
        }
        return h
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isActive {
            return 1
        }
        return 2
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}















