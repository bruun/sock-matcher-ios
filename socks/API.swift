//
//  API.swift
//  socks
//
//  Created by Thomas Bruun on 06/05/2017.
//  Copyright © 2017 Socks Inc. All rights reserved.
//

import Foundation
import Alamofire

class API {
    
    static var currentUser : User?
    static var currentSock : Sock?
    
    static func login(username: String, completion: () -> Void) {
        let user = User()
        user.id = "id"
        user.name = "Thomas"
        currentUser = user
        completion()
    }
    
    static func getOwnSocks(completion: (_ socks : [Sock]) -> Void) {
        let sock1 = Sock()
        sock1.title = "Lonely sock"
        sock1.image = #imageLiteral(resourceName: "SockExample")
        let sock2 = Sock()
        sock2.title = "Sock there"
        sock2.image = #imageLiteral(resourceName: "SockExample")
        let sock3 = Sock()
        sock3.title = "Sock everywhere"
        sock3.image = #imageLiteral(resourceName: "SockExample")
        let socks = [sock1, sock2, sock3]

        currentUser?.socks = []
        completion(socks)
    }
    
    static func getSocksToMatch(completion: (_ socks : [Sock]) -> Void) {
        let sock1 = Sock()
        sock1.title = "I'm a lonely sock"
        sock1.image = #imageLiteral(resourceName: "SockExample")
        let sock2 = Sock()
        sock2.title = "Looking to rock your socks on"
        sock2.image = #imageLiteral(resourceName: "SockExample")
        let sock3 = Sock()
        sock3.title = "Sock looking for a soulmate"
        sock3.image = #imageLiteral(resourceName: "SockExample")
        let socks = [sock1, sock2, sock3]
        completion(socks)
    }
    
    static func matchSock(sock:Sock, completion: (_ didMatch: Bool) -> Void) {
        completion(true)
    }
}
