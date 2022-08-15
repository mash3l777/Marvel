//
//  AppProperties.swift
//  Marvel
//
//  Created by مشعل المعمري on 10/08/2022.
//

import Foundation

let appProperties = AppProperties()
let api = API()

class AppProperties: NSObject {
    
    let baseURL = "https://gateway.marvel.com"
    
    let characters = "/v1/public/characters"
    
    
    
    func getPublicKey() -> String {
        if let apiPublicKey = Bundle.main.infoDictionary?["API_PUBLIC_KEY"] as? String {
            return apiPublicKey
        }else{
            return ""
        }
    }
    
    func getPrivateKey() -> String {
        if let apiPublicKey = Bundle.main.infoDictionary?["API_PRIVATE_KEY"] as? String {
            return apiPublicKey
        }else{
            return ""
        }
        
    }
    
}
