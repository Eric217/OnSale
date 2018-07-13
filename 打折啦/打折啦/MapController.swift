//
//  MapViewController.swift
//  frame
//
//  Created by Eric on 7/14/17.
//  Copyright © 2017 Eric. All rights reserved.
//

import Foundation
import UIKit
class MapViewController: UIViewController {
    
    var secondController: MapSearchController!
    
    var shadowView: UIView!
    
    var swp: UISwipeGestureRecognizer!
    var pn: UIPanGestureRecognizer!
    
    var mapView: MAMapView!
    var effectView: UIVisualEffectView!
    
    var usrRepre: MAUserLocationRepresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBase()
        initMap()
        //initSecondViewController()
        
      
        
        
        
    }
    
    func initBase() {
        view.backgroundColor = UIColor.groupTableViewBackground
        effectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        effectView.frame = myRect(0, 0, ScreenWidth, 20)
       
    }
    
    func initSecondViewController() {
        
        secondController = MapSearchController()
        
        addChildViewController(secondController)
        shadowView.addSubview(secondController.view)
        view.addSubview(shadowView)

        
        
        
        
    }
    
    func initMap() {
        mapView = MAMapView(frame: view.bounds)
        mapView.delegate = self
        mapView.addSubview(effectView)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        usrRepre = MAUserLocationRepresentation()
        usrRepre.showsAccuracyRing = false
        usrRepre.showsHeadingIndicator = true
        
        /* 与 AccuracyRing相关：
        usrRepre.fillColor
        usrRepre.strokeColor
        usrRepre.lineWidth
        usrRepre.enablePulseAnnimation
         与 location dot 相关
        usrRepre.locationDotBgColor
        usrRepre.locationDotFillColor
        usrRepre.image
        */
 
        view.addSubview(mapView)
        mapView.update(usrRepre)
        mapView.isShowsIndoorMap = true
        
        initCompass()
        initScale()
        
        //mapView.setZoomLevel(3, animated: true)
        
        //第一个参数是 location2D
        //mapView.setCenter(, animated: true)

        //手势默认全部开启
        
        //mapView.screenAnchor = CGPoint(x: 0.5, y: 0.5)  //anchor
        
        /* 与地图类型与展示内容相关
        mapView.mapType = .navi
        mapView.isShowTraffic = false
        mapView.isShowsLabels = true
        */
    }
    
    func initCompass(x: CGFloat = -100, y: CGFloat = 22 ) {
        mapView.compassOrigin.y = y
        if x != -100 {
            mapView.compassOrigin.x = x
        }
    }
    
    func initScale(x: CGFloat = -100, y: CGFloat = 22 ) {
        
        mapView.scaleOrigin.y = y
        if x != -100 {
            mapView.scaleOrigin.x = x
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //关于限制区域：
        //mapView.isRotateEnabled = false 后，下面：
        //mapView.limitRegion = MACoordinateRegion(center: 2D, span: MACSpan)
    
        //截屏:
        //let a: UIImage = mapView.takeSnapshot(in: myRect(, , , ))
        
        //大头针(有回调方法)
        //let pointAnno = MAPointAnnotation()
        //pointAnno.coordinate =
        //pointAnno.title = ""
        //pointAnno.subtitle = ""
        //mapView.addAnnotation(pointAnno)
        
    }
    
    
    
    
}

extension MapViewController: MAMapViewDelegate {
    
    //内容代理
    //callout: 气泡
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        guard annotation.isKind(of: MAPointAnnotation.self) else { return nil }
        
        var annoView = mapView.dequeueReusableAnnotationView(withIdentifier: Identifier.pointReuseId)
        if annoView == nil {
            annoView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: Identifier.pointReuseId)
        }
        annoView?.canShowCallout = true
        annoView?.isDraggable = false
        annoView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        //let idx = mapView.annotations.index()
       
        
        
        return annoView!
        
    }
    
    
    
    
}








