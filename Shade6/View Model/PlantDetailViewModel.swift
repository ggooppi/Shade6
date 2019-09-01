//
//  PlantDetailViewModel.swift
//  Shade6
//
//  Created by gopinath.a on 02/09/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import Foundation
import ObjectMapper

class PlantDetailViewModel: NSObject {
    var plantsDetail = PlantDetail()
    var selectedPlantURL = String()
    
    func fetchPlantDetail(completionHandler: @escaping (_ status:Bool, _ error: String?) -> Void) -> Void {
        Webservice.shared.getPlantsDetail(url: selectedPlantURL, parameters: ["":""]) { (status, response, header, error) in
            if status{
                if let responseObject = response{
                    if let main_species = responseObject["main_species"] as? [String: Any]{
                        let a = Mapper<PlantDetail>().map(JSON: main_species)
                        self.plantsDetail = a!
                        print(self.plantsDetail)
                        completionHandler(true, nil)
                    }
                }
            } else{
               completionHandler(false, "Something Went Wrong")
            }
        }
    }
}
