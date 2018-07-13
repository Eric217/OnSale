//
//  四种cell.swift
//  打折啦
//
//  Created by Eric on 13/09/2017.
//  Copyright © 2017 INGStudio. All rights reserved.
//

import Foundation
//放图片的cell
class ImageCollectionViewCell: UICollectionViewCell {
    
    var img: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        img = UIImageView()
        img.contentMode = .scaleToFill
        addSubview(img)
        img.snp.makeConstraints { make in
            make.center.size.equalTo(self)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}






