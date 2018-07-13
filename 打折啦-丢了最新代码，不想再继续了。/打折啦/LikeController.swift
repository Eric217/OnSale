//
//  LikeController.swift
//  打折啦
//
//  Created by Eric on 15/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
import Alamofire

class LikeController: UIViewController {
    
    var collection: UICollectionView!
    var itemId: Int!
    var refreshFooter: MJRefreshAutoNormalFooter!
    
    var dataArr = NSMutableArray()
    var currPage = 1
    var _3: [String]!
    var toSearchType: Int!
    var delegate: ScrollSizeDidChangeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let lay = UICollectionViewFlowLayout()
        collection = UICollectionView(frame: CGRect(), collectionViewLayout: lay)
        collection.delegate = self
        collection.dataSource = self
        collection.register(ELItemViewCell.self, forCellWithReuseIdentifier: Identifier.resultofSearchCellId)
        view.addSubview(collection)
        collection.snp.makeConstraints { make in
            make.center.size.equalTo(view)
        }
        refreshFooter = MJRefreshAutoNormalFooter {
            self.currPage += 1
            self.loadData(self.currPage)
        }
        refreshFooter.setTitle("---- 我是有底线的 ----", for: .noMoreData)
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = UIColor.groupTableViewBackground
        //delegate?.addFooter(refreshFooter)
        collection.mj_footer = refreshFooter
        loadData(currPage)
        delegate?.change(by: 46)
    }
    
    func initial(loca: [String], type: Int, dele: ScrollSizeDidChangeDelegate) {
        _3 = loca
        toSearchType = type >= 100 ? type - 100 : type
        delegate = dele
    }
    
    func loadData(_ page: Int) {
        Alamofire.request(Router.getGoods(-1, toSearchType, currPage, 10, -1, _3[0], _3[1], _3[2], "", 1)).validate().responseJSON { response in
            switch response.result {
            case .failure(let err):
                print(dk,err)
      
                hud.showError(withStatus: "网络异常")
                self.refreshFooter.endRefreshingWithNoMoreData()
                self.refreshFooter.setTitle(" ", for: .noMoreData)
            case .success(let value):
                let v = JSON(value as! NSDictionary)
                let data_ = v["data"]["data"].arrayValue
                for i in 0..<data_.count {
                    let item = Good()
                    item.anlyse(data_[i])
                    self.dataArr.add(item)
                }
                var b: CGFloat = 0
                self.view.snp.updateConstraints { make in
                    let a = CGFloat(ceil((Double(self.dataArr.count)/2.0)))
                    if a == 0 {
                        make.height.equalTo(46)
                    }else {
                        b = itemCellH*a + lineSpacing*(a-1)
                        make.height.equalTo(b+46)
                    }
                }
                self.delegate?.change(by: self.currPage == 1 ? b : b-5*itemCellH-4*lineSpacing)
                if data_.count < 10 || self.currPage == 2 {
                    self.refreshFooter.endRefreshingWithNoMoreData()
                }else {
                    self.refreshFooter.endRefreshing()
                }
                self.collection.reloadData()
            }
            
        }

        
    }
    
    
}
extension LikeController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.resultofSearchCellId, for: indexPath) as! ELItemViewCell
        cell.fillContents(dataArr[indexPath.item])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let vc = DetailController()
        vc.item = dataArr[indexPath.item] as! Good
        pushWithoutTab(vc)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: lineSpacing, bottom: 0, right: lineSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemCellW, height: itemCellH)
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int {
       
        return dataArr.count
        
    }
    
}







