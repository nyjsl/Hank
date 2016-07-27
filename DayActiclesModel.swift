//
//  DayActiclesModel.swift
//  Gank
//
//  Created by 魏星 on 16/7/20.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class DayActiclesModel: BaseModel<GankIOApi>{
    
    var dayArticlesEntity: DayArticlesEntity<ArticleEntity>?
    
    override init() {
        super.init()
    }
    
    func getArticlesByDay(year: String,month: String, day: String) -> Observable<DayArticlesEntity<ArticleEntity>>{
        let articlesByDay =  requestProvider.request(GankIOApi.DayDateByYMD(year: year, month: month, day: day))
            .observeOn(backgroundScheduler).map { (response) -> DayArticlesEntity<ArticleEntity> in
                if let result = Mapper<DayArticlesEntity<ArticleEntity>>().map(String(data: response.data, encoding: NSUTF8StringEncoding)){
                    return result
                }else{
                    throw NSError(domain: "parse json error", code: -1, userInfo: ["json": response])
                }
        }
        return articlesByDay.doOnNext({ (entity) in
            print("doOnNext")
            print(entity)
            self.dayArticlesEntity = entity
        }).observeOn(MainScheduler.instance)
    }
}
