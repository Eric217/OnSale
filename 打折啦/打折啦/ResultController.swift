//
//  ResultController.swift
//  打折啦
//
//  Created by Eric on 09/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
import Alamofire
class ResultController: UIViewController {
    
    var keyword: String!
    var navBar: SearchingNavBar!
    var collection: UICollectionView!
    var refreshFooter: MJRefreshAutoNormalFooter!
    
    //基础数据
    var userid = -1, type = -1, selected = -1, currPage = 1
    var time = false, location = false, all = true, distance = false
    var changed = ["全部", "最新", "最近"]
    var defalt = ["选择地点", "时间", "距离"]
    var address3 = ["全部", "", ""]
    var currentLoca = ["全部", "", ""]
    lazy var dataArr = NSMutableArray()

    //定位相关
    var locationManager: CLLocationManager!
    var locatedButFailed = false
    var search: AMapSearchAPI!
    
    //
    init(key: String?) {
        super.init(nibName: nil, bundle: nil)
        keyword = key
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBar()
        setupCollection()
        loadData()
        getLocation()
    }
    
    //MARK: - 数据填充
    
    func loadData(page: Int = 1) {
        
        if page == 1 {
            currPage = 1
            dataArr.removeAllObjects()
            refreshFooter.resetNoMoreData()
        }
        var _3: [String]
        if location {
            _3 = address3.convert()
        }else if distance {
            _3 = currentLoca.convert()
        }else {
            _3 = changed.convert()
        }

        Alamofire.request(Router.getGoods(-1, type, currPage, 10, userid, _3[0], _3[1], _3[2], navBar.search.text!, 1)).validate().responseJSON { response in
            switch response.result {
            case .failure(let err):
                print(dk,err)
                #if DEBUG
                    let a = Good()
                    a.title = "Hey，快来看又打折了！"
                    a.smallPics = [""]
                    a.date = "2017-09-02 12:40:00"
                    a.threeLevel = ["1", "3daqe", "dadefw"]
                    a.location = "location"
                    a.date = "2016-08-09 09:09:09"
                    a.deadline = "2017-10-09 09:09:09"
                    a.picRatio = "1.5|0.9"
                    a.id = 12
                    a.isValid = 1
                    a.long = 39.9
                    a.lati = 116.4
                    a.type = 122
                    a.description = "descr: 1230"
                    let me = Person()
                    me.id = 10
                    me.phone = "13176370907"
                    me.nickName = "Catherine1323224"
                    me.psd = "12345754323"
                    me.gender = "男"
                    me.mark = 100
                    me.type = 1
                    me.signature = "wocao???"
                    me.realName = ""
                    me.realID = ""
                    me.email = ""
                    me.birthday = "1901-01-01"
                    me.fans = 0
                    me.analyse([:])
                    a.user = me
                    self.dataArr.add(a)
                    self.dataArr.add(a)
                    self.collection.reloadData()
                #endif
                self.refreshFooter.endRefreshingWithNoMoreData()

            case .success(let value):
                let v = JSON(value as! NSDictionary)
                let data_ = v["data"]["data"].arrayValue
                if self.currPage == 1 {
                    self.dataArr.removeAllObjects()
                }
                for i in 0..<data_.count {
                    let item = Good()
                    item.anlyse(data_[i])
                    self.dataArr.add(item)
                }
                if data_.count < 10 {
                    self.refreshFooter.endRefreshingWithNoMoreData()
                }else {
                    self.refreshFooter.endRefreshing()
                }
                self.collection.reloadData()
            }
            
        }
    }
    
    func getLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        guard CLLocationManager.locationServicesEnabled() else { return }
        locationManager.startUpdatingLocation()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARK: - 基础流程控制
extension ResultController: UIGestureRecognizerDelegate, UISearchBarDelegate {

    @objc func shaixuan() {
        print("shaixuan")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        var poi = touch.location(in: navBar.location)
        if navBar.location.bounds.contains(poi) {
            selected = 0; return true
        }
        poi = touch.location(in: navBar.all)
        if navBar.all.bounds.contains(poi) {
            selected = 1; return true
        }
        poi = touch.location(in: navBar.time)
        if navBar.time.bounds.contains(poi) {
            selected = 2; return true
        }
        poi = touch.location(in: navBar.distance)
        if navBar.distance.bounds.contains(poi) {
            selected = 3; return true
        }
        return false
    }
    
    @objc func didTap() {
        var inLocate = true
        switch selected {
        case 0:
            inLocate = false
            BRAddressPickerView.showAddressPicker(withDefaultSelected: [0, 0, 0], tintColor: Config.themeColor, isAutoSelect: false, resultBlock: { address in
                inLocate = true
                self.address3 = address as! [String]
                self.changeTxt(strs: self.address3)
                self.location = true
                self.all = self.navBar.all.changeStatus(false)
                self.distance = self.navBar.distance.changeText(self.defalt[2], forceBold: false)
            })
        //点击综合
        case 1:
            if all { return }
            selectAllItem()
        //点击时间
        case 2:
            time = navBar.time.changeText(!time ? changed[1] : defalt[1], forceBold: !time)
            if time {
                all = navBar.all.changeStatus(false)
            }
        //点击距离
        case 3:
            if locatedButFailed {
                presentAlert("获取位置失败", "请在设置中打开定位服务或者稍后再试", .alert, actTitle:
                    "设置", { _ in self.openURL() })
            }
            distance = navBar.distance.changeText(!distance ? changed[2] : defalt[2], forceBold: !distance)
            if distance {
                all = navBar.all.changeStatus(false)
                location = navBar.location.changeText(defalt[0], forceBold: false)
            }
        default: break
        }
        if !location && !time && !distance && !all {
            all = navBar.all.changeStatus(true)
        }
        if inLocate == false { return }
        loadData()
    }
    
    func selectAllItem() {
        all = navBar.all.changeStatus(true)
        location = navBar.location.changeText(defalt[0], forceBold: false)
        time = navBar.time.changeText(defalt[1], forceBold: false)
        distance = navBar.distance.changeText(defalt[2], forceBold: false)
    }
    
    func changeTxt(strs: [String]) {
        if strs[0] == changed[0] {
            navBar.location.changeText("全部省市", forceBold: true)
        }else if strs[1] == changed[0] {
            navBar.location.changeText(strs[0], forceBold: true)
        }else if strs[2] == changed[0] {
            navBar.location.changeText(strs[1], forceBold: true)
        }else {
            navBar.location.changeText(strs[2], forceBold: true)
        }
    }
    
    @objc func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let vcs = navigationController!.viewControllers
        if vcs[1].isKind(of: MySearchController.self) {
            navigationController?.setViewControllers([vcs[0], vcs[2]], animated: false)
            navigationController?.pushViewController(vcs[1], animated: false)
        }else {
            pushWithoutTab(MySearchController(navBar.search.text!))
        }
        return false
    }

}

//MARK: - LocationManager&AMapSearch Delegate
extension ResultController: CLLocationManagerDelegate, AMapSearchDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locatedButFailed = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locatedButFailed = false
        
        if locations.count > 0 {
            locationManager.stopUpdatingLocation()
        }
        let coord = (locations.last)!.coordinate
   
        let point_ = AMapGeoPoint.location(withLatitude: CGFloat(coord.latitude), longitude: CGFloat(coord.longitude))
        
        search = AMapSearchAPI()
        search.delegate = self
        
        let request = AMapReGeocodeSearchRequest()
        request.location = point_
        search.aMapReGoecodeSearch(request)
        
    }
    
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        guard let result = response.regeocode else { return }
        let ad = result.addressComponent!
        currentLoca = [ad.province, ad.city, ad.district]
        if distance {
            loadData()
        }
    }
    
    ///高德解码失败代理方法
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        print(dk+"search·aMapRegoecodeSearch失败------------")
        
    }

    
    
}












