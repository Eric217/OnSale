


import Foundation
import Alamofire
class LocationChooser: UIViewController {
    
    var delegate: ValueRecaller?
    var table: UITableView!
 
    var locationManager: CLLocationManager!
    var long = 0.0, lati = 0.0
    //格式化地址
    var formatted = ""
    
    ///自己的位置
    var point: CLLocation!
    ///含有省市区街道等等等等组分的
    var address: AMapAddressComponent!
    
    var search: AMapSearchAPI!
    
    var activity: UIActivityIndicatorView!
    
    var refreshHeader: MJRefreshHeader!
    var refreshFooter: MJRefreshAutoNormalFooter!
    
    var belowLayer: CAGradientLayer!
    
    var searchController: UISearchController!
    
    var searching1: Bool!
    var searching2: Bool!
    
    lazy var dataArr = [AMapPOI]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBase()
        setupBar()
        setupTable()
        locate()
    }
    
   
    func loadMore() {
        refreshFooter.endRefreshing()
    }
    
    func locate() {
        guard CLLocationManager.locationServicesEnabled() else {
        //系统会自动弹窗提醒打开
            return
        }
        print("I am locating ------------")
        activity.startAnimating()
        locationManager.startUpdatingLocation()
        
        
    }
    
    func refresh() {
        if !self.activity.isAnimating {
            
            self.locate()
        }else {
            refreshHeader.endRefreshing()
        }
        
    }
    
    func endRefresh() {
        activity.stopAnimating()
        refreshHeader.endRefreshing()
        searching1 = false
        searching2 = false
    }
    
    
}


//MARK: - view and some small delegate methods

extension LocationChooser: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            navigationController?.pushViewController(LocationFiller(), animated: true); return
        }
        //address + lon + lat + loca
        let poi = dataArr[indexPath.row]
        delegate?.transferLocation([address, lati, long, poi.address+" "+poi.name])
        navigationController?.popViewController(animated: true)
    }

    //MARK: - view of location chooser

    func setBase() {
        title = "地点"
        view.backgroundColor = UIColor.groupTableViewBackground
        
        refreshHeader = MJRefreshNormalHeader {
            self.refresh()
        }
        refreshFooter = MJRefreshAutoNormalFooter {
            self.loadMore()
        }
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 5
    
    }
    
    func setupTable() {
    
        table = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .plain)
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: Identifier.locachooseCellId)
        view.addSubview(table)
        table.mj_header = refreshHeader
        table.tableFooterView = UIView()
    
    }
    
    func setupBar() {
        
        belowLayer = CAGradientLayer()
        belowLayer.zPosition = -1
        let color = Config.themeColor
        let color1 = color.getWhiter(by: 0.55)
        belowLayer.colors = [color.cgColor, color1.cgColor]
        belowLayer.frame = myRect(0, -20, ScreenWidth, 64)
        belowLayer.startPoint = CGPoint(x: 0, y: 0.5)
        belowLayer.endPoint = CGPoint(x: 1, y: 0.5)
        navigationController?.navigationBar.layer.addSublayer(belowLayer)
        
        navBarShadowImageHidden = true
        navBarBackgroundAlpha = 0
        navBarTintColor = UIColor.white
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItem = rightItem
        
        let size: CGFloat = 17
        activity = UIActivityIndicatorView(frame: myRect(ScreenWidth/2-40, 22-size/2, size, size))
        activity.activityIndicatorViewStyle = .gray
        navigationController?.navigationBar.addSubview(activity)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activity.stopAnimating()
    }
    
}








