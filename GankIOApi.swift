//
//  GankIOApi.swift
//  Gank
//
//  Created by 魏星 on 16/7/17.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import Moya

struct GANKIO{
    
    static let BASE_URL = "http://gank.io/api"
    
}

public enum GankIOApi{
    
    case RandomData(kind: String ,count: Int)
    //分页获取某类数据
    case ByPageAndKind(kind: String ,page: Int ,count: Int)
    
    case DayDateByYMD(year: String, month: String, day: String)
    
}

extension GankIOApi: TargetType{
    public var baseURL: NSURL { return NSURL(string: GANKIO.BASE_URL)! }
    public var path: String {
        switch self {
        case .RandomData(let kind, let count):
            return "/random/data/\(kind)/\(count)"
        case .ByPageAndKind(let kind, let page, let count):
            return "/data/\(kind)/\(count)/\(page)"
        case .DayDateByYMD(let year, let month, let day):
            return "/day/\(year)/\(month)/\(day)"
        }
    }
    public var method: Moya.Method {
        switch self {
        default:
            return .GET
        }
    }
    public var parameters: [String: AnyObject]? {
        switch self {
        default:
            return nil
        }
    }
    
    public var multipartBody: [MultipartFormData]? { return nil }
    
    public var sampleData: NSData {
        return "{}".dataUsingEncoding(NSUTF8StringEncoding)!
    }
}