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
    var otherSock : Sock? {
        didSet {
            self.otherSockImageView?.kf.setImage(with: URL(string: otherSock!.imageUrl!))
            self.label?.text = otherSock?.title
        }
    }
    
    var mySock : Sock? {
        didSet {
            self.mySockImageView?.kf.setImage(with: URL(string: mySock!.imageUrl!))
        }
    }
    
    @IBOutlet weak var label : UILabel?
    @IBOutlet weak var otherSockImageView : UIImageView?
    @IBOutlet weak var mySockImageView : UIImageView?
    
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
