//
//  ResponseObjects.swift
//  LoveEvery_CA
//
//  Created by Logan Klein on 11/10/20.
//

import Foundation
import ObjectMapper

class GenericResponse: Mappable {
    
    var statusCode: Int?
    var body: String?
    
    //MARK: - Init Methods
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    // MARK: - Mappable
    func mapping(map: Map) {
        statusCode  <- map["statusCode"]
        body        <- map["body"]
    }
}

class AllMessagesResponse: GenericResponse {
    
    var messages: [Message] = []
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        parseItems()
    }
    
    func parseItems() {
        // Because the body is returned as a json string rather than nested objects, we must do additional conversion
        guard let bodyData = body?.data(using: .utf8) else {
            print("unable to parse body data")
            return
        }
        
        guard let json = WebServiceManager.dataToJSON(data: bodyData) else {
            print("unable to convert to JSON")
            return
        }
        
        // Because the keys are dynamic and at the top level of the parsed object, we must collect these to allow for proper data mapping
        messages.removeAll()
        for key in json.keys {
            guard let value = json[key] as? [[String:Any]] else {
                print("unable to parse value to dictionary")
                return
            }
            
            let userMessages = Mapper<Message>().mapArray(JSONArray: value)
            messages.append(contentsOf: userMessages)
        }
        
        return
    }
}

class UserMessagesResponse: GenericResponse {
    var userInfo: UserInfo?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        parseItems()
    }
    
    func parseItems() {
        // Because the body is returned as a json string rather than nested objects, we must do additional conversion
        guard let bodyData = body?.data(using: .utf8) else {
            print("unable to parse body data")
            return
        }
        
        guard let json = WebServiceManager.dataToJSON(data: bodyData) else {
            print("unable to convert to JSON")
            return
        }
        
        userInfo = UserInfo(JSON: json)
    }
}
