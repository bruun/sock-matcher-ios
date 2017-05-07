//
//  SwipeOverlayView.swift
//  socks
//
//  Created by Thomas Bruun on 07/05/2017.
//  Copyright © 2017 Socks Inc. All rights reserved.
//

import Foundation
import UIKit
import DMSwipeCards

class SwipeOverlayView : UILabel {

    var mode : SwipeMode? {
        didSet {
            text = mode == .left ? "👎" : "👍"
            backgroundColor = mode == .left ? UIColor.red : UIColor.green
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    func setupView() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        font = UIFont.systemFont(ofSize: 24)
        textAlignment = .center
    }
}
