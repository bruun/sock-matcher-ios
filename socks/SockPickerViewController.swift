//
//  SockPickerViewController.swift
//  socks
//
//  Created by Thomas Bruun on 06/05/2017.
//  Copyright © 2017 Socks Inc. All rights reserved.
//

import Foundation
import UIKit

class SockPickerViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let reuseIdentifier = "sockCell"
    @IBOutlet weak var sockCollection : UICollectionView?
    var socks : [Sock] = []
    
    override func viewDidLoad() {
        API.getOwnSocks { (socks : [Sock]) in
            self.socks = socks
            sockCollection?.reloadData()
        }
    }
    
    func pickSock(sock : Sock) {
        API.currentSock = sock
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "SockPickerToMatcher", sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sock = socks[indexPath.row]
        pickSock(sock: sock)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SockCell
        let sock = socks[indexPath.row]
        cell.label?.text = sock.title
        cell.imageView?.image = sock.image
        return cell
    }
    
}
