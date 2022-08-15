//
//  CharactersAPI.swift
//  Marvel
//
//  Created by مشعل المعمري on 10/08/2022.
//

import UIKit
import Alamofire
import CryptoKit


extension API {
    
    class Characters: NSObject {
        
        // MARK: - Fetch Characters List
        func fetchCharacters(limit:Int, offset:Int, vc:UIViewController, completionHandler: @escaping CompletionHandler) {
            
            let ts:String = String(Date().timeIntervalSince1970)
            let publicKey:String = "***REMOVED***"
            let privateKey:String = "***REMOVED***"
            let hash:String = MD5(string: ts + privateKey + publicKey)
            
            let url = appProperties.baseURL + appProperties.characters + "?ts=" + ts + "&apikey=" + publicKey + "&hash=" + hash
            
            let headers : HTTPHeaders = [
               "Content-Type": "application/json",

            ]
            
            api.request(method: .get, url: url, parameters: nil, headers: headers, vc: vc, of: CharacterDataWrapper.self, completionHandler: completionHandler
            )
        }
        
    }
    
}



func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}
