//
// Copyright ©2023 유니메오.
// All Rights Reserved.
//

import Foundation
import Alamofire
import UIKit


class AlamofireManager {
    
    static let shared = AlamofireManager()
    
    private init() {}
}

extension AlamofireManager {
    func responseProcess(response: AFDataResponse<Data>) throws -> (dict: NSDictionary?, message: String?) {
        switch response.result {
        case .success(let result):
            guard let result = (try? JSONSerialization.jsonObject(with: result, options: .mutableContainers)) as? [String: Any] else {
                print("response Data Error : ", response.request?.urlRequest?.description ?? "")
                throw ServerErrorStruct.init(msg: "Server Error(1)", req: response.request?.urlRequest?.description)
            }
            
            guard let code = result["code"] as? Int, (200...300).contains(code) else {
                print("\(result["message"] as? String ?? "data code is not 200...300") : ", response.request?.urlRequest?.description ?? "")
                throw ServerErrorStruct.init(msg: "\(result["message"] ?? "Server Error(2)")", req: response.request?.urlRequest?.description)
            }
            
            let message = result["message"] as? String
            
            let data = result["data"] as? NSDictionary
            
            if data == nil, message == nil {
                print("data, message is nil : ", response.request?.urlRequest?.description ?? "")
                throw ServerErrorStruct.init(msg: "Server Error(3)", req: response.request?.urlRequest?.description)
            }
            
            return (data, message)
        case .failure(let error):
            throw ServerErrorStruct.init(msg: error.localizedDescription, req: response.request?.urlRequest?.description)
        }
    }
}

extension AlamofireManager {
    
    func asyncQueryRequest(router: APIRouter) async throws -> (dict: NSDictionary?, message: String?) {
        let response = await AF.request(router).serializingData().response
        let data = try responseProcess(response: response)
        
        return data
    }
    
    func asyncFormDataRequest(router: APIRouter) async throws -> (dict: NSDictionary?, message: String?) {
        let response = await AF.upload(multipartFormData: router.multipartFormData, with: router).serializingData().response
        let data = try responseProcess(response: response)
        return data
    }
}

///server serror
struct ServerErrorStruct : Error {
    var msg : String
    var req: String?
}

///local serror
struct LocalErrorStruct : Error {
    var msg : String
    var className: String?
}
