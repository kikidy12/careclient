//
// Copyright ©2023 유니메오.
// All Rights Reserved.
//

import Foundation


// MARK: - Custom Decoder
class MyDecoder: JSONDecoder {
    
    static let shared = MyDecoder()
    
    override init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
        
        dateDecodingStrategy = .custom({
            let dateStr = try $0.singleValueContainer().decode(String.self)
            
            if let str = dateStr.stringToDate(formatter: "yyyy-MM-dd HH:mm:ss") {
                return str
            }
            else if let str = dateStr.stringToDate(formatter: "yyyy-MM-dd") {
                return str
            }
            else {
                return dateStr.stringToDate(formatter: "HH:mm:ss")!
            }
        })
        
    }
    
    
    func createObj<T: Decodable>(_ type: T.Type, data: Any) -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            
            let decode = try self.decode(T.self, from: jsonData)
            
            return decode
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            return nil
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return nil
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return nil
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return nil
        } catch {
            print("error: ", error)
            return nil
        }
    }
}
