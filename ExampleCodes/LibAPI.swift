//
//  LibAPI.swift
//  ExampleCodes
//
//  Created by boqian cheng on 2017-10-03.
//  Copyright © 2017 boqiancheng. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import Moya

public enum LibAPI {
    case libInfo
}

extension LibAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: "https://data.cityofchicago.org/resource")!
    }
    
    public var path: String {
        switch self {
        case .libInfo:
            return "/x8fc-8rcq.json"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        switch self {
        case .libInfo:
            return "Test sample.".data(using: String.Encoding.utf8)!
        }
    }
    
    public var task: Task {
        switch self {
        case .libInfo:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
}


