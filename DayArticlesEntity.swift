//
//  BaseEntityDay.swift
//  Gank
//
//  Created by 魏星 on 16/7/20.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import ObjectMapper
class DayArticlesEntity<T: Mappable>: Mappable{
    
    var category: [String]?
    
    var error: Bool?
    
    var results: [String: [T]]?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        category <- map["category"]
        error <- map["error"]
        results <- map["results"]
    }
    
}