//
//  CommentController.swift
//  打折啦
//
//  Created by Eric on 13/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
import Alamofire
protocol ScrollSizeDidChangeDelegate {
    func change(by: CGFloat)
    func loadLike(_ withData: Bool)
    func addFooter(_ footer: MJRefreshAutoNormalFooter)
}

class CommentController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var table: UITableView!
    var cell0: UITableViewCell!
    var itemId: Int!
    var uploaderId: Int!
    var delegate: ScrollSizeDidChangeDelegate?
    
    var dataArr = NSMutableArray()
    var total = 0
    var currPage = 0
    var refreshFooter: MJRefreshAutoNormalFooter!
    var totalHeight: CGFloat = 0
    var lastHeight: CGFloat = 0
    var refreshTimes = 1
    let footerHeight: CGFloat = 46
    let headerHeight: CGFloat = 46
    var ended = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupRefresh()
        loadData()
    }
    
    func initial(_ itemID: Int, upId: Int, dele: ScrollSizeDidChangeDelegate?) {
        itemId = itemID
        uploaderId = upId
        delegate = dele
    }
    
    func setupTable() {
        view.backgroundColor = UIColor.white
        cell0 = UITableViewCell()
        cell0.addBottomLine(height: 0.5, color: UIColor.lightGray.withAlphaComponent(0.6))
        cell0.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightSemibold)
        cell0.textLabel?.text = " 留言·0"
        
        view.addSubview(cell0)
        cell0.snp.makeConstraints { make in
            make.left.top.equalTo(0)
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(headerHeight)
        }
        
        table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(ELCommentCell.self, forCellReuseIdentifier: Identifier.commentCellId)
        //table.isScrollEnabled = false
        view.addSubview(table)
        table.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.top.equalTo(cell0.snp.bottom)
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(headerHeight)
        }
        let v = UIView(frame: myRect(0, 0, ScreenWidth, 0.5))
        v.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        table.tableFooterView = v
        
        delegate?.change(by: footerHeight+headerHeight+0.5)
        view.snp.updateConstraints { make in
            make.height.equalTo(headerHeight+footerHeight)
        }
        
    }
    
    func setupRefresh() {
        
        refreshFooter = MJRefreshAutoNormalFooter {
            self.refreshTimes += 1
            self.loadData()
        }
        refreshFooter.setTitle("点击加载更多评论", for: .idle)
        refreshFooter.setTitle("猜你喜欢", for: .noMoreData)
        table.mj_footer = refreshFooter
    }
 
    func endRefreshWithNoData() {
        refreshFooter.endRefreshingWithNoMoreData()
        if !ended {
            if dataArr.count == 0 {
                delegate?.loadLike(false)
            }else {
                delegate?.loadLike(true)
            }
            ended = true
        }
    }
    
    func loadData() {
        currPage += 1
        Alamofire.request(Router.getComment(1, itemId, currPage, 10)).validate().responseJSON{ response in
            switch response.result {
            case .failure(let r):
                
                #if DEBUG
                    let com = Comment()
                    com.user = userDefau.getCustomObj(for: "1"+userGeneralKey) as! Person
                    com.content = "cahakcdaihcabajceewiuefjwlsnjnrgnsm,v"
                    com.date = "2017-08-09 09:09:09"
                    com.goodsId = 20
                    com.id = 323
                    com.type = 1
                    for i in 0..<10 {
                        if i % 3 == 0 {
                            com.content = "adawa"
                        }else if i % 2 == 0 {
                            com.content = "我才查擦多长时间看哪会吧阿萨侧分三大发打算打算打算打算"
                        }
                        self.dataArr.add(com)
                    }
                    
                
                
                
                
                
                
                
                
                self.totalHeight = 0
                    self.table.reloadData()
                self.endRefreshWithNoData()
                return
                    #endif
                
                
                hud.showError(withStatus: "网络异常")
                print(dk, r)
                self.endRefreshWithNoData()
            case .success(let v):
                let originalDict = JSON(v)["data"]
                self.cell0.textLabel?.text = " 留言·\(originalDict["total"].int!)"
                let dataArray = originalDict["data"].arrayValue

                for i in 0..<dataArray.count {
                    let comm = Comment()
                    comm.analyse(dataArray[i], upId: self.uploaderId)
                    self.dataArr.add(comm)
                }
                if dataArray.count < 10 {
                    self.endRefreshWithNoData()
                }else {
                    self.refreshFooter.endRefreshing()
                }
            
                self.totalHeight = 0
                self.table.reloadData()
            }
        }
        
        
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = dataArr[indexPath.row] as! Comment
        let cell = ELCommentCell(style: .default, reuseIdentifier: Identifier.commentCellId)
        cell.fillContents(comment)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    ///这个方法会被调两次！一次初始调，一次在cellForRowAt时一边一边的调！
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let a = autoCalculateSize((dataArr[indexPath.row] as! Comment).content, size: 17, maxSize: mySize(ScreenWidth-85, 100), lineSpa: 4).height + 3
        if a > 25 {
            totalHeight += 75+a
            if indexPath.row == dataArr.count-1 {
                changeY()
            }
            return 75 + a
        }
        totalHeight += 100
        if indexPath.row == dataArr.count-1 {
            changeY()
        }
        return 100
    }
 
    func changeY() {
        refreshTimes -= 1
        if refreshTimes < 0 { refreshTimes = 0; return }
        view.snp.updateConstraints { make in
            make.height.equalTo(totalHeight+headerHeight+footerHeight)
        }
        table.snp.updateConstraints { make in
            make.height.equalTo(totalHeight+footerHeight)
        }
        let toAdd = totalHeight - lastHeight
        lastHeight = totalHeight
        self.delegate?.change(by: toAdd)
    }
    
}





