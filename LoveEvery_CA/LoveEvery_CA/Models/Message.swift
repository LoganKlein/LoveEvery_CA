//
//  Message.swift
//  LoveEvery_CA
//
//  Created by Logan Klein on 11/9/20.
//

import Foundation
import ObjectMapper

class Message: Mappable {
    var subject: String?
    var message: String?
    
    //MARK: - Init Methods
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    // MARK: - Mappable
    func mapping(map: Map) {
        subject <- map["subject"]
        message <- map["message"]
    }
}
