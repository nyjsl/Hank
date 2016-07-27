//
//  CategoryEntity.swift
//  Gank
//
//  Created by 魏星 on 16/7/27.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import ObjectMapper
class CategoryEntity: Mappable{
    
    var id: Int?
    var name: String?
    var icon: String?
    var type: Int?
    var has_content_rank: Int?
    var has_banner: Int?
    var index: Int?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
        type <- map["type"]
        has_content_rank <- map["has_content_rank"]
        has_banner <- map["has_banner"]
        index <- map["index"]

    }
    
}
