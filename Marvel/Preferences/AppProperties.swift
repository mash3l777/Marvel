//
//  AppProperties.swift
//  Marvel
//
//  Created by مشعل المعمري on 10/08/2022.
//

import Foundation
import SafariServices

let appProperties = AppProperties()
let api = API()

class AppProperties: NSObject {
    
    let baseURL = "https://gateway.marvel.com"
    
    let characters = "/v1/public/characters"
    
    
    
    func getPublicKey() -> String {
        guard var apiPublicKey = Bundle.main.infoDictionary?["API_PUBLIC_KEY"] as? String else {  fatalError()}
         apiPublicKey = apiPublicKey.replacingOccurrences(of: "\"" , with: "")
            return apiPublicKey

    }
    
    func getPrivateKey() -> String {
        guard var apiPrivateKey = Bundle.main.infoDictionary?["API_PRIVATE_KEY"] as? String else {  fatalError()}
        apiPrivateKey = apiPrivateKey.replacingOccurrences(of: "\"" , with: "")

            return apiPrivateKey
    }
    
    
    func showWepPage(vc:UIViewController,strURL: String) {
        if let url = URL(string: strURL) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            config.barCollapsingEnabled = true
            let sfSafariViewController = SFSafariViewController(url: url, configuration: config)
            sfSafariViewController.modalPresentationStyle = .pageSheet
            sfSafariViewController.preferredControlTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            vc.present(sfSafariViewController, animated: true)
        }
    }
    
}
