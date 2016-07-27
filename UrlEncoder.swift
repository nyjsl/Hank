//
//  UrlEncoder.swift
//  Gank
//
//  Created by 魏星 on 16/7/27.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
public class UrlEnocder{
    
    public static func encodeUrl(input: NSString) -> NSURL?{
        if let urlStr: String = input.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding){
            
            if let nsUrl = NSURL(string: urlStr){
                return nsUrl
            }
        }
        return nil
    }
    
}
