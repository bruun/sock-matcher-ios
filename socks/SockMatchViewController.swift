//
//  SockMatchViewController.swift
//  socks
//
//  Created by Thomas Bruun on 06/05/2017.
//  Copyright © 2017 Socks Inc. All rights reserved.
//

import Foundation
import UIKit

class SockMatchViewController : UIViewController {
    @IBOutlet weak var statusLabel : UILabel?

    override func viewWillAppear(_ animated: Bool) {
        if API.didWin {
            self.statusLabel?.text = "You won the sock! A drone will deliver it momentarily"
        } else {
            self.statusLabel?.text = "You lost the sock! A drone will fetch it momentarily"
        }
        self.statusLabel?.setNeedsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
