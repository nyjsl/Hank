//
//  ArticleEntity.swift
//  Gank
//
//  Created by 魏星 on 16/7/17.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import ObjectMapper
class ArticleEntity: Mappable{
    
    var _id: String?
    var createdAt: NSDate?
    var desc: String?
    var publishedAt: NSDate?
    var type: String?
    var url: String?
    var used: Bool?
    var who: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        _id <- map["_id"]
        createdAt <- (map["createdAt"],MyDateFormatTransform())
        desc <- map["desc"]
        publishedAt <- (map["publishedAt"],MyDateFormatTransform())
        type <- map["type"]
        url <- map["url"]
        used <- map["used"]
        who <- map["who"]

    }
    
}