//
//  SockView.swift
//  socks
//
//  Created by Thomas Bruun on 06/05/2017.
//  Copyright © 2017 Socks Inc. All rights reserved.
//

import Foundation
import UIKit

class SockView : UIView {
    var sock : Sock? {
        didSet {
            self.imageView?.image = sock?.image
            self.label?.text = sock?.title
        }
    }
    
    @IBOutlet weak var label : UILabel?
    @IBOutlet weak var imageView : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    class func instanceFromNib() -> SockView {
        return UINib(nibName: "SockView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SockView
    }
    
    func setupView() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 30.0
    }
}
