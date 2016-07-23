//
//  BaseModel.swift
//  Gank
//
//  Created by 魏星 on 16/7/17.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper

class BaseModel{
    
    var requestProvider: RxMoyaProvider<GankIOApi>
    
    var page = 1
    var offset = 20
    
    var backgroundScheduler: OperationQueueScheduler!
    
    init(){
        
        let operationQueue = NSOperationQueue()
        operationQueue.maxConcurrentOperationCount = 3
        operationQueue.qualityOfService = .UserInitiated
        
        backgroundScheduler = OperationQueueScheduler(operationQueue: operationQueue)
        
        let networkActivityPlugin = NetworkActivityPlugin { (change) in
            
            switch(change){
            case .Began:
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            case .Ended:
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false

            }
        }
        
        self.requestProvider = RxMoyaProvider<GankIOApi>(plugins: [networkActivityPlugin,NetworkLoggerPlugin.init()])
    }
    
    func parseObject<T: Mappable>(response: Response) throws -> T {
        return try Mapper<T>().map(response.mapString())!
    }
    
}
