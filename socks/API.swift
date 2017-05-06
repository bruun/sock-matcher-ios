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
    static var didWin = false
    
    static func login(username: String, password: String, completion: @escaping () -> Void) {
        let user = User()
        user.id = "id"
        user.name = "Thomas"
        user.username = username
        user.password = password
        currentUser = user
        completion()
    }
    
    static func getAuthHeaders() -> HTTPHeaders {
        var headers: HTTPHeaders = [:]
        if let authorizationHeader = Request.authorizationHeader(user: currentUser!.username!, password: currentUser!.password!) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        return headers
    }
    
    static func getOwnSocks(completion: @escaping (_ socks : [Sock]) -> Void) {
        Alamofire.request("http://localhost:8000/socks/mine/", headers: getAuthHeaders())
            .responseJSON { response in
                
                let sockJsonArray = response.result.value as! Array<Dictionary<String, Any>>
                let socks = sockJsonArray.map({ (obj : Dictionary) -> Sock in
                    let sock = Sock()
                    sock.id = obj["id"] as? Int
                    sock.title = obj["name"] as? String
                    sock.imageUrl = obj["image"] as? String
                    return sock
                })
                
                currentUser?.socks = []
                completion(socks)
        }
    }
    
    static func getSocksToMatch(completion: @escaping (_ socks : [Sock]) -> Void) {
        Alamofire.request("http://localhost:8000/socks/", headers: getAuthHeaders())
            .responseJSON { response in
                
                let sockJsonArray = response.result.value as! Array<Dictionary<String, Any>>
                let socks = sockJsonArray.map({ (obj : Dictionary) -> Sock in
                    let sock = Sock()
                    sock.id = obj["id"] as? Int
                    sock.title = obj["name"] as? String
                    sock.imageUrl = obj["image"] as? String
                    return sock
                })

                completion(socks)
        }
    }
    
    static func matchSock(sock:Sock, completion: @escaping (_ didMatch: Bool) -> Void) {
        let parameters : [String: Any] = [
            "target_sock": sock.id!,
            "preference": 1
        ]
        Alamofire.request("http://localhost:8000/socks/\(currentSock!.id!)/preferences/", method: .post, parameters: parameters, headers: getAuthHeaders())
            .responseJSON { response in
                let resultDict = response.result.value as! Dictionary<String, Any>
                guard let isMatch = resultDict["is_match"] else {
                    completion(false)
                    return
                }
                completion(isMatch as! Bool)        }
    }
    
    static func rejectSock(sock:Sock, completion: @escaping () -> Void) {
        let parameters : [String: Any] = [
            "target_sock": sock.id!,
            "preference": 2
        ]
        Alamofire.request("http://localhost:8000/socks/\(currentSock!.id!)/preferences/", method: .post, parameters: parameters, headers: getAuthHeaders())
            .responseJSON { response in
                completion()
        }
    }
    
    static func getMatch(sock : Sock, completion: @escaping () -> Void) {
        Alamofire.request("http://localhost:8000/socks/\(currentSock!.id!)/match/", headers: getAuthHeaders())
            .responseJSON { response in
                let winnerSockId = ((response.result.value as! Dictionary<String, Any>)["winner_sock"] as! Dictionary<String, Any>)["id"] as! Int
                didWin = winnerSockId == currentSock?.id
                completion()
        }
    }
}
