//
// Copyright ©2023 유니메오.
// All Rights Reserved.
//


import Foundation
import Alamofire
import UIKit


///개발서버주소
fileprivate let DEV_URL : String = "dev url"
///운영서버주소
fileprivate let LIVE_URL : String = "live url"

//기본url 설정
enum HTTPURL {
    static var BASE_URL : String {
        if Config.isDebug {
            return DEV_URL
        }
        else {
            return LIVE_URL
        }
    }
}


///헤더 필드
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case accessToken = "X-Http-Token"
}

///request parameter type
enum ContentType: String {
    case json = "application/json"
    case multipart = "multipart/form-data"
}

///api 버전
enum APIVersion: String {
    case v1 = "/v1"
    case v2 = "/v2"
    case v3 = "/v3"
    case v4 = "/v4"
    case v5 = "/v5"
}

enum APIRouter: URLRequestConvertible {
    
    // MARK: - api enum case
    
    // MARK: - api path
    fileprivate var path: String {
        switch self {
        }
    }
    
    fileprivate var apiVersion: String {
        switch self {
        default :
            return ""
        }
    }
    
    // MARK: - api HttpMethod
    fileprivate var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    // MARK: - 파라미터 인코딩 방식
    fileprivate var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
    fileprivate var baseURL: URL {
        switch self {
        default:
            return URL(string: HTTPURL.BASE_URL)!
        }
    }
    
    // MARK: - api header - 토큰 사용여부
    fileprivate var header: HTTPHeader? {
        switch self {
        default:
            return HTTPHeader(name: HTTPHeaderField.accessToken.rawValue, value: "userToken")
        }
    }
    
    // MARK: - query/body 파라미터
    fileprivate var parameters: Parameters? {
        switch self {
        
        default:
            return nil
        }
    }
    
    // MARK: - multipartFormData 파라미터
    var multipartFormData: MultipartFormData {
        let multipartFormData = MultipartFormData()
        switch self {
            
        default: ()
        }
        
        return multipartFormData
    }
    
    
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(apiVersion).appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.method = method
        
        if let header = header {
            urlRequest.headers.add(header)
        }
        
        urlRequest.setValue(ContentType.multipart.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}
