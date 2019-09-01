//
//  PlantList.swift
//  Shade6
//
//  Created by gopinath.a on 01/09/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import Foundation
import ObjectMapper

class PlantList: NSObject, Mappable {
    var scientificName = String()
    var link = String()
    var id = Int()
    var completeData = Bool()
    var commonName = String()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        scientificName <- map["scientific_name"]
        link <- map["link"]
        id <- map["id"]
        completeData <- map["complete_data"]
        commonName <- map["common_name"]
    }
}
