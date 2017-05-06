//
//  SockCell.swift
//  socks
//
//  Created by Thomas Bruun on 06/05/2017.
//  Copyright © 2017 Socks Inc. All rights reserved.
//

import Foundation
import UIKit

class SockCell : UICollectionViewCell {
    @IBOutlet weak var label : UILabel?
    @IBOutlet weak var imageView : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
