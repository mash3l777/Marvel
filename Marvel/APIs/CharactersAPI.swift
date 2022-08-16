//
//  CharactersAPI.swift
//  Marvel
//
//  Created by مشعل المعمري on 10/08/2022.
//

import UIKit
import Alamofire


extension API {
    
    class Characters: NSObject {
        
        // MARK: - Fetch Characters List
        func fetchCharacters(limit:Int, offset:Int, vc:UIViewController, completionHandler: @escaping CompletionHandler) {
            
            let ts:String = "\(Int(Date().timeIntervalSince1970))"
            
            let hash = MD5(string: ts + appProperties.getPrivateKey() + appProperties.getPublicKey())
            let publicKey = appProperties.getPublicKey()
            let url = appProperties.baseURL + appProperties.characters + "?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
            
            let headers : HTTPHeaders = [
               "Content-Type": "application/json",

            ]
            
            api.request(method: .get, url: url, parameters: nil, headers: headers, vc: vc, of: CharacterDataWrapper.self, completionHandler: completionHandler
            )
        }
        
    }
    
}
