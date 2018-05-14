//
//  ITModel.swift
//  ImageTask
//
//  Created by Kapil Rathore on 13/05/18.
//  Copyright © 2018 Kapil Rathore. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol ITModelType {
    func fetchImageData(completionHandler: @escaping ([ITResponseObject], String?)->())
}

class ITModel: ITModelType {
    
    private let requestURL = "http://dev.deltaapp.in/api/assignment"
    
    func fetchImageData(completionHandler: @escaping ([ITResponseObject], String?)->()) {
        
        Alamofire.request(requestURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseArray { (response: DataResponse<[ITResponseObject]>) in
            
            switch response.result {
                
            case .failure(let error):
                completionHandler([], error.localizedDescription)
                
            case .success(let value):
                if value.count > 0 {
                    completionHandler(value, nil)
                } else {
                    completionHandler([], "No data found.")
                }
            }
        }
    }
}
