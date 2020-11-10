//
//  WebServiceManager.swift
//  LoveEvery_CA
//
//  Created by Logan Klein on 11/9/20.
//

import Foundation
import Alamofire
import ObjectMapper

class WebServiceManager: NSObject {
    let sessionManager = Alamofire.Session.default
    let baseAPIURL = "https://abraxvasbh.execute-api.us-east-2.amazonaws.com/proto"
    static var instance: WebServiceManager!
    
    // MARK: - Shared Instance
    
    class func shared() -> WebServiceManager {
        self.instance = (self.instance ?? WebServiceManager())
        return self.instance
    }
    
    // MARK: - API Calls
    
    func getMessages(_ callback: @escaping(_ messages: [Message]?) -> ()) {
        let endpoint = "\(baseAPIURL)/messages"
        sessionManager.request(endpoint, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil) .response { response in
            if let jsonData = response.data {
                if let json = WebServiceManager.dataToJSON(data: jsonData) {
                    let response = AllMessagesResponse(JSON: json)
                    callback(response?.messages)
                    return
                }
            }
        }
    }
    
    func getMessages(forUser: String,_ callback: @escaping(_ messages: [Message]?) -> ()) {
        let endpoint = "\(baseAPIURL)/messages/\(forUser)"
        sessionManager.request(endpoint, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil) .response { response in
            if let jsonData = response.data {
                if let json = WebServiceManager.dataToJSON(data: jsonData) {
                    let response = UserMessagesResponse(JSON: json)
                    callback(response?.userInfo?.messages)
                    return
                }
            }
        }
    }
    
    func postMessage(user: String, subject: String, message: String, _ callback: @escaping(_ success: Bool) -> ()) {
        var parameters = Parameters()
        parameters["user"] = user
        parameters["operation"] = "add_message"
        parameters["subject"] = subject
        parameters["message"] = message
        
        let endpoint = "\(baseAPIURL)/messages"
        sessionManager.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil) .response { response in
            if let jsonData = response.data {
                if let json = WebServiceManager.dataToJSON(data: jsonData) {
                    let item = GenericResponse(JSON: json)
                    callback(item?.statusCode == 200)
                    return
                }
            }
        }
    }
    
    // MARK: - JSON Extraction
    
    public class func dataToJSON(data: Data) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as? [String : Any]
        } catch let myJSONError {
            print(myJSONError)
        }
        
        return nil
    }
}
