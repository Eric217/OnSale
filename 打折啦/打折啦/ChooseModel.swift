//
//  CustomLocation.swift
//  打折啦
//
//  Created by Eric on 07/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation

//MARK: - location manager delegate
extension LocationChooser: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(dk+"location manager 协议里失败-------")
        endRefresh()
        
        //
        presentAlert("允许\"定位\"提示", "在设置中打开定位服务", .alert, actTitle: "设置", { _ in
            self.openURL()
        })
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if locations.count > 0 {
            locationManager.stopUpdatingLocation()
        }
        ///自己的位置
        point = (locations.last)!
        let coord = point.coordinate
        long = coord.longitude
        lati = coord.latitude
        let point_ = AMapGeoPoint.location(withLatitude: CGFloat(lati), longitude: CGFloat(long))
        
        search = AMapSearchAPI()
        search.delegate = self
        
        let request = AMapReGeocodeSearchRequest()
        request.location = point_
        
        let request2 = AMapPOIAroundSearchRequest()
        request2.location = point_
        request2.types = "汽车销售|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|科教文化服务|金融保险服务"
        request2.requireExtension = true
        
        searching1 = false
        searching2 = false
        search.aMapPOIAroundSearch(request2)
        search.aMapReGoecodeSearch(request)

    }
    
    
    
    
    //MARK: - AMapSearchDelegate
    
    ///高德解码成功代理方法,这里只弄地址。其他的给另一个代理
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        
        guard let result = response.regeocode else { return }
        formatted = (result.formattedAddress)//, result.addressComponent)
        address = result.addressComponent
        searching1 = true
        reloadD()
    }
    
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.count == 0 { return }
        print(response.count)
        //response.suggestion在手打poi时用
        dataArr = response.pois
        searching2 = true
        reloadD()
    }
    
    func reloadD() {
        if searching2 && searching1 {
            endRefresh()
            table.reloadData()
            
        }
    }
    
    ///高德解码失败代理方法
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        print(dk+"search·aMapRegoecodeSearch失败------------")
        endRefresh()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section == 1 else {
            let cell = RightLabelCell()
            if dataArr.count == 0 {
                cell.setLeftText("无法自动获取位置", color: .lightGray)
                table.mj_footer = nil
            }else {
                cell.setLeftText(address.province+" "+address.city+" "+address.district, color: .darkGray)
                if table.mj_footer == nil {
                    table.mj_footer = refreshFooter
                }
            }
            cell.setRightText("自定义", color: .gray)
            return cell
        }
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: Identifier.locachooseCellId)
        if dataArr.count == 0 {
            refreshFooter.setTitle("fwdwsdw ", for: .idle)
        }else {
            refreshFooter.setTitle("点击或上拉加载更多", for: .idle)
        }
        let poi = dataArr[indexPath.row]
        cell.textLabel?.text = poi.name
        cell.detailTextLabel?.text = poi.address
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.image = UIImage(named: "locate")
        
        
        return cell
    }
    
}

extension LocationChooser: AMapSearchDelegate {

}

