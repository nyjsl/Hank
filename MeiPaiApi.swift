//
//  MeiPaiApi.swift
//  Gank
//
//  Created by 魏星 on 16/7/26.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import Moya
struct MeiPaiScheme {
    static let BaseUrl = "https://newapi.meipai.com"
    static let Category = "channels/header_list.json?language=zh-Hans"
    static let VideoList = "/channels/feed_timelin.json"
    static let HotVideoList = "hot/feed_timeline.json"
}

struct MeiPaiKey {
    static let IDKey = "id"
    static let TypeKey = "type"
    static let PageKey = "page"
    static let CountKey = "count"
}

struct DefaultValues {
    static let Count = 20
}

enum MeiPaiApi{
    
    case  GetCategoryList
    case  GetHotVideoList(page: Int,count: Int)
    case  GetVideoList(id: Int,type: Int,page: Int,count: Int)
    
}

extension MeiPaiApi: TargetType{
    var baseURL:NSURL {
        return NSURL(string: MeiPaiScheme.BaseUrl)!
    }
    var path: String {
        switch self {
        case .GetCategoryList:
            return MeiPaiScheme.Category
        case.GetVideoList(id: _,type: _, page: _, count: _):
            return MeiPaiScheme.VideoList
        case .GetHotVideoList(page: _, count: _):
            return MeiPaiScheme.HotVideoList
        }
    }
    var method: Moya.Method {
        return .GET
    }
    var parameters: [String: AnyObject]? {
        switch self {
        case .GetCategoryList:
            return nil
        case .GetHotVideoList(let page, let count):
            return [MeiPaiKey.PageKey: page,MeiPaiKey.CountKey: count]
        case .GetVideoList(let id, let type,let page, let count):
            return [MeiPaiKey.IDKey: id,MeiPaiKey.TypeKey: type,MeiPaiKey.PageKey: page,MeiPaiKey.CountKey: count]
        }
    }
    
    var multipartBody: [MultipartFormData]? { return nil }
    
    var sampleData: NSData {
        return "{}".dataUsingEncoding(NSUTF8StringEncoding)!
    }
}