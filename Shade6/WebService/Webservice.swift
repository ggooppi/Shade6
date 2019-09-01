//
//  Webservice.swift
//  Shade6
//
//  Created by gopinath.a on 01/09/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public class Webservice: NSObject {
    
    //MARK: Properties
    static let shared = Webservice()
    
    func getPlants(parameters: [String: Any], completionHandler: @escaping ((_ status: Bool, _ response: [[String:Any]]?, _ header: [String:Any]?, _ error:String?) -> Void)) -> Void {
        
        let header = ["Authorization": kAuthorization]
        Alamofire.request(kPlantListURL, method: .get, parameters: parameters, headers: header)
            .validate()
            .responseJSON { (response) in
                switch response.result{
                case .success(_):
                    if let responseObject = response.result.value as? [[String:Any]]{
                        if let responseHeader = response.response?.allHeaderFields as? [String:Any]{
                            completionHandler(true, responseObject, responseHeader, nil)
                        } else{
                            completionHandler(true, responseObject, nil, nil)
                        }
                    }
                case .failure(_):
                    completionHandler(false, nil, nil, "Something Went Wrong")
                }
        }
    }
    
    func getPlantsDetail(url: String, parameters: [String: Any], completionHandler: @escaping ((_ status: Bool, _ response: [String:Any]?, _ header: [String:Any]?, _ error:String?) -> Void)) -> Void {
        
        let header = ["Authorization": kAuthorization]
        Alamofire.request(url.replacingOccurrences(of: "http", with: "https"), method: .get, headers: header)
            .validate()
            .responseJSON { (response) in
                switch response.result{
                case .success(_):
                    if let responseObject = response.result.value as? [String:Any]{
                        if let responseHeader = response.response?.allHeaderFields as? [String:Any]{
                            completionHandler(true, responseObject, responseHeader, nil)
                        } else{
                            completionHandler(true, responseObject, nil, nil)
                        }
                    }
                case .failure(_):
                    completionHandler(false, nil, nil, "Something Went Wrong")
                }
        }
    }
}
