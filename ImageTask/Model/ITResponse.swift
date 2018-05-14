//
//  ITResponse.swift
//  ImageTask
//
//  Created by Kapil Rathore on 14/05/18.
//  Copyright © 2018 Kapil Rathore. All rights reserved.
//

import Foundation
import ObjectMapper

struct ITResponseObject: Mappable {
    
    var id: Int = 0
    var createdAt: String = ""
    var updatedAt: String = ""
    var name: String = ""
    var email: String = ""
    var imageURL: String = ""
    
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        id              <- map["id"]
        createdAt       <- map["created_at"]
        updatedAt       <- map["updated_at"]
        name            <- map["name"]
        email           <- map["email"]
        imageURL        <- map["image"]
    }
    
    func getDateString(for dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let dateDate = formatter.date(from: dateString) else { return "" }
        formatter.dateFormat = "MMM dd"
        return formatter.string(from: dateDate)
    }
}
