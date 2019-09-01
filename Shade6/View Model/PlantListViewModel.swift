//
//  PlantListViewModel.swift
//  Shade6
//
//  Created by gopinath.a on 01/09/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import Foundation
import ObjectMapper


class PlantListViewModel: NSObject {
    
    var plants = [PlantList]()
    var numberOfPages = 0
    var currnetPage = 1
    
    func fetchPlantList(completionHandler: @escaping (_ status:Bool, _ error: String?) -> Void) -> Void {
        let params = ["complete_data": "true"]
        Webservice.shared.getPlants(parameters: params) { (status, response, header, error) in
            if status{
                if let headeValue = header{
                    if self.numberOfPages != 0{
                        if let pages = headeValue["total-pages"] as? Int{
                            self.numberOfPages = pages
                        }
                    }
                }else{
                    print("Error")
                }
                
                if let responseObject = response{
                    self.plants = Mapper<PlantList>().mapArray(JSONArray: responseObject )
                    print(self.plants)
                }
                completionHandler(true, nil)
            }else{
                completionHandler(true, error!)
            }
        }
    }
    
}
