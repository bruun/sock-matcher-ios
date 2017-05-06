//
//  SockMatcherViewController.swift
//  socks
//
//  Created by Thomas Bruun on 06/05/2017.
//  Copyright © 2017 Socks Inc. All rights reserved.
//

import Foundation
import UIKit
import DMSwipeCards

class SockMatcherViewController : UIViewController, DMSwipeCardsViewDelegate {
    
    var swipeView : DMSwipeCardsView<Sock>!
    @IBOutlet weak var emptyLabel : UILabel?
    
    override func viewDidLoad() {
     
        let viewGenerator: (Sock, CGRect) -> (UIView) = { (element: Sock, frame: CGRect) -> (UIView) in
            let container = SockView.instanceFromNib()
            container.frame = CGRect(x: 30, y: 20, width: frame.width - 60, height: frame.height - 40)
            container.otherSock = element
            container.mySock = API.currentSock
            
            return container
        }
        
        let overlayGenerator: (SwipeMode, CGRect) -> (UIView) = { (mode: SwipeMode, frame: CGRect) -> (UIView) in
            let label = UILabel()
            label.frame.size = CGSize(width: 100, height: 100)
            label.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
            label.layer.cornerRadius = label.frame.width / 2
            label.backgroundColor = mode == .left ? UIColor.red : UIColor.green
            label.clipsToBounds = true
            label.text = mode == .left ? "👎" : "👍"
            label.font = UIFont.systemFont(ofSize: 24)
            label.textAlignment = .center
            return label
        }
        
        let frame = CGRect(x: 0, y: 80, width: self.view.frame.width, height: self.view.frame.height - 160)
        swipeView = DMSwipeCardsView<Sock>(frame: frame,
                                             viewGenerator: viewGenerator,
                                             overlayGenerator: overlayGenerator)
        swipeView.delegate = self
        self.view.addSubview(swipeView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Load socks from backend
        API.getSocksToMatch() { (socks : [Sock]) in
            self.swipeView.addCards(socks)
        }
    }
    
    func swipedLeft(_ object: Any) {
        // Rejected the sock
        API.rejectSock(sock: object as! Sock) { () in
            
        }
    }
    
    func swipedRight(_ object: Any) {
        let sock = object as! Sock
        API.matchSock(sock: sock) { (didMatch : Bool) in
            if (didMatch) {
                API.getMatch(sock: sock, completion: {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "MatcherToMatch", sender: self)
                    }
                })
            }
        }
    }
    
    func cardTapped(_ object: Any) {
        // This should probably not do anything yet
    }
    
    func reachedEndOfStack() {
        emptyLabel?.isHidden = false
    }
}
