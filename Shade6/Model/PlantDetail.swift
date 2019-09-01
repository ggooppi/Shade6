//
//  PlantDetail.swift
//  Shade6
//
//  Created by gopinath.a on 01/09/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import Foundation
import ObjectMapper

enum LabelInformationType: String {
    case about = "About"
    case specification = "Specification"
}

class PlantDetail: NSObject, Mappable {
    
    var id = Int()
    var images = [Image]()
    var nativeStatus = String()
    var type = String()
    var familyCommonName = String()
    var duration = String()
    var commonName = String()
    var specifications = Specifications()
    
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        images <- map["images"]
        nativeStatus <- map["native_status"]
        type <- map["type"]
        familyCommonName <- map["family_common_name"]
        duration <- map["duration"]
        commonName <- map["common_name"]
        specifications <- map["specifications"]
    }
}

class Image: NSObject, Mappable {
    var url = String()
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        url <- map["url"]
    }
}

class Specifications: NSObject, Mappable {
    var toxicity = ""
    var shape_and_orientation = ""
    var regrowth_rate = ""
    var nitrogen_fixation = ""
    var lifespan = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        toxicity <- map["toxicity"]
        shape_and_orientation <- map["shape_and_orientation"]
        regrowth_rate <- map["regrowth_rate"]
        nitrogen_fixation <- map["nitrogen_fixation"]
        lifespan <- map["lifespan"]
    }
    
}
