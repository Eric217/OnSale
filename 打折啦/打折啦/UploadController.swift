//
//  UploadView.swift
//  打折啦
//
//  Created by Eric on 7/26/17.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
import Alamofire

//upload 时候，picRatio是   长：宽的值1|2,都是 float
//这个扩展包括 texfield， texview， scrollview
extension UpLoadViewController: UITextFieldDelegate, UITextViewDelegate {
    
//MARK: -  @objc functions

    @objc func fabu() {
        let bigImgArr: [UIImage]
        let smaImgArr: [UIImage]


        
        if txf.text!.len() <= 1 {
            hud.showError(withStatus: "标题过短"); return
        }
        if location.textLabel?.text == chooseLoca {
            hud.showError(withStatus: "请选择地点"); return
        }
        if type == -1 {
            hud.showError(withStatus: "请选择种类"); return
        }else if business.status {
            type += 100
        }
        if l3 == "" {
            hud.showError(withStatus: "")
        }

        
        bigImgArr = getBigImageArray() as! [UIImage]
        smaImgArr = getSmallImageArray() as! [UIImage]

        let dict = ["type": type, "title": (txf.text)!, "description": (txv.text)!,
                    "l1": l1, "l2": l2, "l3": l3, "location": locaStr, "longitude": lon,
                    "latitude": lat, "deadline": deadLine] as [String : Any]
     
        
        let data1 = Data()
        let imageData1 = Data()
        let imageSmallData1 = Data()
        
        Alamofire.upload(multipartFormData: { multi in
            /*
            //这几个是那几个string或int，double的属性的数据的拼接，name一会写接口里的，
            multi.append(data1, withName: "name")
            multi.append(data1, withName: "name")
            multi.append(data1, withName: "name")
            multi.append(data1, withName: "name")
            multi.append(data1, withName: "name")
            multi.append(data1, withName: "name")
            //下面是 大图数据.其中第三个参数是 扩展名，是个可选参数，
            multi.append(imageData1, withName: "pic1")
            multi.append(imageData1, withName: "pic2", mimeType: "jpg")
            multi.append(imageData1, withName: "pic3")
            //下面是 小图数据
            multi.append(imageSmallData1, withName: "picSmall1", mimeType: "jpg")
            multi.append(imageSmallData1, withName: "picSmall")
            multi.append(imageSmallData1, withName: "picSmall")

            multi.append(<#T##data: Data##Data#>, withName: <#T##String#>, fileName: <#T##String#>, mimeType: <#T##String#>)
             */
            
        }, with: Router.upGood, encodingCompletion: { encodeResult in
            switch encodeResult {
            case .success(let upload, _, _): upload
                .uploadProgress { progress in
                    print(progress.fractionCompleted)
                    
                    
                    
                }
                .responseJSON { response in
                    
                    
                    
                }
                
            case .failure(let error):
                print(dk+"\(error)")
            }
            
        })
        

        
    
    }
    
    @objc func didClick(_ sender: RoundButton) {
        let ta = sender.tag
        if ta != 201 {
            if ta == 202 || ta == 203 {
                sender.changeStatus(true)
            }else {
                sender.changeStatus()
            }
        }else{
            print("😄弹出视图")
        }
      
        
    }
    
    @objc func cancel(){
        print(hh+"是否保存草稿 ")
        dismiss(animated: true, completion: nil)
        
        
    }
    
    @objc func showtip() {
        print("😄弹出视图")
        
        
    }
    
    @objc func didTap(_ sender: UITapGestureRecognizer) {
        let temp = sender.view

        if temp == location {
            let controller = LocationChooser()
            controller.delegate = self
            navigationController?.pushViewController(controller, animated: true)
        }else if temp == kind {
            let controller = TypeChooser()
            controller.delegate = self
            navigationController?.pushViewController(controller, animated: true)
        }else if temp == time {
            BRStringPickerView.showStringPicker(withTitle: "", dataSource: timeArr, defaultSelValue: time.rightLabel.text!, isAutoSelect: false, tintColor: Config.themeColor, resultBlock: { result in
                self.time.setRightText(result as! String)
                for i in 0..<self.timeArr.count {
                    if self.timeArr[i] == (result as! String) {
                        self.deadLine = self.dateArr[i]
                        break
                    }
                }
            })
        }
    }
    
 

//MARK: - 回调与重要的几个方法

    ///value: y值。x值是屏幕宽度.dir默认0，如果不是0，就是变化量
    func updateContentSize(value: CGFloat = 0, dir: CGFloat = 0) {
        if dir == 0 {
            scrollView.contentSize = CGSize(width: ScreenWidth, height: value)
        }else {
            let h = scrollView.contentSize.height
            scrollView.contentSize = CGSize(width: ScreenWidth, height: h + dir)
        }
    }
    
    override func pickerViewFrameChanged() {
        let pickH = pickerCollectionView.frame.height
        if pickH != currPickerHeight {
            updateContentSize(dir: pickH - currPickerHeight)
            currPickerHeight = pickH
            
        }
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        updateScrollFrameY(true)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        updateScrollFrameY()
    }
    
    ///默认值为false 原位置
    func updateScrollFrameY(_ drag: Bool = false) {
        UIView.animate(withDuration: 0.2, animations: {
            if drag {
                self.scrollView.contentOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.frame.height)
            }
        }) { finished in
            if finished && drag {
                self.txv.becomeFirstResponder()
            }
        }
    }
    


//MARK: - some methods not that important

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        scrollView.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField.text!.len() < 25 else {
            return false
        }
        return true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ///如果不设置这个，在推出地址选择器再回来时，出发didBeginEditing的动画，类似QQ。
        scrollView.endEditing(true)
    }
    
}

//MARK: - 实现了回调传值
extension UpLoadViewController : ValueRecaller {
    
    
    
    
    func transferLocation(_ value: [Any]) {
        
        
    }
    
    func transferType(_ value: String, position: Int) {
        kind.setRightText(value)
        type = position
    }



}



/*
 class UpLoadView: UIView {
 
 override init(frame: CGRect) {
 super.init(frame: frame)
 //alpha = 0.5
 //        let view2 = UIScrollView(frame: CGRect(x: 0, y: 30, width: view.bounds.width, height: view.bounds.height))
 //        view2.backgroundColor = UIColor.white
 //        let maskPath = UIBezierPath(roundedRect: view2.bounds, byRoundingCorners:
 //            [UIRectCorner.topRight, UIRectCorner.topLeft], cornerRadii: CGSize(width: 8, height: 8))
 //        let maskLayer = CAShapeLayer()
 //        maskLayer.frame = view2.bounds
 //        maskLayer.path = maskPath.cgPath
 //
 //        view2.layer.mask = maskLayer
 //
 //        view.addSubview(view2)
 //
 //        view2.isUserInteractionEnabled = true
 //        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
 //        view2.addGestureRecognizer(gesture)
 
 
 }
 
 required init?(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 
 
 }
 */
