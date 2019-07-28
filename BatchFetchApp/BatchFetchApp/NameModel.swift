//
//  NameModel.swift
//  BatchFetchApp
//
//  Created by dmason on 7/28/19.
//  Copyright © 2019 dmason. All rights reserved.
//

import Foundation
import ObjectMapper

class NameModel: NSObject, Mappable
{
    var id : UUID?
    var firstName : String?
    var lastName : String?
    var updateTime : Date?
    var removed : Bool?
    
    override init()
    {
        super.init()
    }
    
    convenience required init?(map: Map)
    {
        self.init()
    }
    
    func mapping(map: Map)
    {
        id = UUID(uuidString: (try! map.value("id") as String?)!)
        
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        removed <- map["removed"]
        
        let dateString = (try! map.value("update_time") as String?)!
        updateTime = dateString.toISO8601Date()
    }
}
