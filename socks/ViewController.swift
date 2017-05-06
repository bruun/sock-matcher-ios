//
//  ViewController.swift
//  socks
//
//  Created by Thomas Bruun on 06/05/2017.
//  Copyright © 2017 Socks Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var usernameInput : UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func performLogin(sender: AnyObject) {
//        if (self.usernameInput?.text?.characters.count == 0) {
//            return
//        }
    
        API.login(username: usernameInput!.text!) {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "LoginToSockPicker", sender: sender)
            }
        }
    }
}
