//
//  BaseEntity.swift
//  Gank
//
//  Created by 魏星 on 16/7/17.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import ObjectMapper
class BaseEntity<T: Mappable>: Mappable {
    
    var error: Bool?
    
    var results: [T]?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        error <- map["error"]
        results <- map["results"]
    }
    
}
