//
//  UserInfo.swift
//  LoveEvery_CA
//
//  Created by Logan Klein on 11/10/20.
//

import Foundation
import ObjectMapper

class UserInfo: Mappable {
    
    var user: String?
    var messages: [Message]?
    
    //MARK: - Init Methods
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    // MARK: - Mappable
    func mapping(map: Map) {
        user        <- map["user"]
        messages    <- map["message"]
    }
}
