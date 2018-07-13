//
//  DetailController.swift
//  打折啦
//
//  Created by Eric on 11/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
class DetailController: UIViewController {
    
    var item: Good!
    var navBar: ELBackNavigationBar!
    var scroll: UIScrollView!
    var tool: ELToolBar!
    var personView: ELPersonCell2!
    var descLabel: AttributedLabel!
    var collection: UICollectionView!
    var vie: UIView!
    var v: AttributedLabel!
    var commControl: CommentController!
    var likeControl: LikeController!
    
    var partHight: CGFloat = -ScreenHeight + 108
    let left: CGFloat = IPHONE5 ? 13 : 18
    var picWidth: CGFloat = 0
    var heightArr: [CGFloat]!
    let seperatorH: CGFloat = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picWidth = ScreenWidth - 2 * left
        setupBars()
        setupWholeScroll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if partHight < 0 && commControl == nil {
            setupComment()
        }
    
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
     
        if commControl == nil && scrollView.contentOffset.y > partHight {
            setupComment()
        }
    }
    
    
    @objc func leaveMsg() {
        
    }
    @objc func collect() {
        
    }
    @objc func talk() {
        
    }
    @objc func goThere() {
        
    }
    @objc func back() {
        
    }
    @objc func shareTo() {
        
    }
    @objc func more() {
        
    }
}

//MARK: - collection setup and delegete
extension DetailController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("cell for item at collection")

        return heightArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.imgCellId, for: indexPath) as! ImageCollectionViewCell
        #if DEBUG
            cell.img.image = #imageLiteral(resourceName: "item")
            return cell
        #endif
        
        cell.img.sd_setImage(with: URL(string: item.pics[indexPath.item]), placeholderImage: #imageLiteral(resourceName: "item"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return mySize(picWidth, heightArr[indexPath.item])
    }
    
}






