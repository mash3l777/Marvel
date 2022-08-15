//
//  API.swift
//  Marvel
//
//  Created by مشعل المعمري on 10/08/2022.
//

import UIKit
import Alamofire
import CryptoKit

class API: NSObject {
    let characters = Characters()
    
    
    //  api response completion handler (success,result,error)
    typealias CompletionHandler = (_ success:Bool, _ result:Any?,_ error:NSError?) -> Void
    
    func request<T: Decodable & Encodable>(method:HTTPMethod ,url:String, parameters: Parameters?,headers:HTTPHeaders ,vc:UIViewController,of: T.Type, completionHandler: @escaping CompletionHandler) {

        
            print("API URL: \(url)")
            print("API Headers: \(headers)")
            print("API Parameters: \(parameters ?? [:])")

           AF.request(url,
                      method: method,
                      parameters: parameters,
                      encoding: JSONEncoding.default,
                      headers: headers
           )
//           .customValidate(url: url, vc: vc)
               .responseDecodable(of: T.self) { response  in
                   
                   switch response.result {
                   case .success:
                   
                       if let responseObj: T = response.value {

                       completionHandler(true, responseObj, nil)
                       
                   }else{
                       completionHandler(false, nil , NSError(domain: "\(type(of: T.self))API",
                                                              code: response.response?.statusCode ?? -1,
                                                              userInfo: ["message" :  NSLocalizedString("faildMsg", comment: "General Faild Message") as NSString]))
                   }

                   case .failure(let error):
                       
                       if let afError = error.asAFError {
                           switch afError {
                           case .sessionTaskFailed(let sessionError):
                               if let urlError = sessionError as? URLError {
                                   print(urlError.localizedDescription)
                                   completionHandler(false, nil,  NSError(domain: "\(type(of: T.self))API", code: urlError.errorCode, userInfo: ["message" : urlError.localizedDescription ]))
                                   
                               }
                           default:
                               print("server not responce")
                               completionHandler(false, nil,  NSError(domain: "\(type(of: T.self))API", code: -500, userInfo: ["message" :  NSLocalizedString("faildMsg", comment: "General Faild Message") as NSString, "response":response]))
                               print(error)
                               
                           }
                       }
                   }
               }
       }
 

}


func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}

//extension DataRequest {
    
    
//    func customValidate(url:String ,vc:UIViewController) -> Self {
//        return self.validate { _, response, _ -> Request.ValidationResult in
//            let statusCode = response.statusCode
//
//            switch statusCode {
//            case 401:
//                debugPrint("Invalid Referer / Invalid Hash --> \(response.debugDescription)")
//
//            case 403:
//                debugPrint("Forbidden --> \(response.debugDescription)")
//
//            case 405:
//                debugPrint("Method Not Allowed --> \(response.debugDescription)")
//
//            case 409:
//                debugPrint("Missing API Key , Missing Hash , Missing Timestamp --> \(response.debugDescription)")
//
//            default:
//                return .success(())
//            }
//        }
//    }
//}
