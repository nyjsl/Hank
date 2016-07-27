//
//  CaterogyModel.swift
//  Gank
//
//  Created by 魏星 on 16/7/27.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
class CategoryModel: BaseModel<MeiPaiApi>{
    
    var caterories: [CategoryEntity]?
    
    override init() {
        caterories = []
        super.init()
    }
    

    func getCategories() -> Observable<[CategoryEntity]> {
    
        return requestProvider.request(MeiPaiApi.GetCategoryList).filterStatusCodes(200...201)
        .observeOn(backgroundScheduler).map { (response) -> [CategoryEntity]in
            if let result = Mapper<CategoryEntity>().mapArray(String(data: response.data, encoding: NSUTF8StringEncoding)){
                return result
            }else{
                 throw NSError(domain: "parse json error", code: -1, userInfo: ["json": response])
            }
        }.doOnNext({ (entities) in
            self.caterories = entities
        }).observeOn(MainScheduler.instance)
    }
}