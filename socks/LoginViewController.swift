//
//  LoginViewController.swift
//  socks
//
//  Created by Thomas Bruun on 06/05/2017.
//  Copyright © 2017 Socks Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameInput : UITextField?
    @IBOutlet weak var passwordInput : UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func performLogin(sender: AnyObject) {
        if (self.usernameInput?.text?.characters.count == 0 ||
            self.passwordInput?.text?.characters.count == 0) {
            return
        }
    
        API.login(username: usernameInput!.text!, password: passwordInput!.text!) {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "LoginToSockPicker", sender: sender)
            }
        }
    }
}
