//
//  RecentArticlesModel.swift
//  Gank
//
//  Created by 魏星 on 16/7/17.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class RecentArticlesModel: BaseModel{
    
    var articleEntities: [ArticleEntity]
    
    override init() {
        articleEntities = []
        super.init()
    }
    
    
    func refresh() -> Observable<[ArticleEntity]>{
        page = 1
        return getArticlesByPage(page)
    }
    
    
    func loadMore() -> Observable<[ArticleEntity]>{
        return getArticlesByPage(page + 1)
    }
    
    func getArticlesByPage(page: Int) -> Observable<[ArticleEntity]>{

        
        let sourceGirl = requestProvider.request(GankIOApi.ByPageAndKind(kind: "福利", page: page, count: self.offset))
            .filterStatusCodes(200...201)
            .observeOn(backgroundScheduler)
            .map { (response) -> [ArticleEntity] in
            if let result = Mapper<BaseEntity<ArticleEntity>>().map(String(data: response.data, encoding: NSUTF8StringEncoding)){
                return result.results!
            }else{
                throw NSError(domain: "parse json error", code: -1, userInfo: ["json": response])
            }
        }
        
        let sourceVideo = requestProvider.request(GankIOApi.ByPageAndKind(kind: "休息视频", page: page, count:  self.offset))
            .filterStatusCodes(200...201)
            .observeOn(backgroundScheduler)
            .map { (response) -> [ArticleEntity] in
            if let result = Mapper<BaseEntity<ArticleEntity>>().map(String(data: response.data, encoding: NSUTF8StringEncoding)){
                return result.results!
            }else{
                throw NSError(domain: "parse json error", code: -1, userInfo: ["json": response])
            }
        }
        
        return Observable.zip(sourceGirl, sourceVideo, resultSelector: { (girls, videos) -> [ArticleEntity] in
            for item in girls{
                item.desc = item.desc! + " " + self.getFirstVideoDescByPublishTime(videos, publishedAt: item.publishedAt!)
            }
            return girls
        }).doOnNext({ (entities) in
            if !entities.isEmpty {
                if page == 1{
                    self.articleEntities = entities
                }else{
                    self.articleEntities += entities
                    self.page = page
                }
            }
        }).observeOn(MainScheduler.instance)
    }
    
    private func getFirstVideoDescByPublishTime(videos: [ArticleEntity],publishedAt: NSDate) -> String{
            var videoDesc = ""
        for item in videos{
            if item.publishedAt == nil{
                item.publishedAt = item.createdAt
            }
            let videoPublishedAt = item.publishedAt
            if DateUtils.areDatesSameDay(videoPublishedAt!, dateTwo: publishedAt){
                videoDesc = item.desc!
                break
            }
        }
        return videoDesc
    }
}