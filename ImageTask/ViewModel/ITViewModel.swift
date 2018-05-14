//
//  ITViewModel.swift
//  ImageTask
//
//  Created by Kapil Rathore on 13/05/18.
//  Copyright © 2018 Kapil Rathore. All rights reserved.
//

import Foundation

protocol ITViewType {
    func apiResponse(sucess: Bool, error: String?)
}

protocol ITViewModelType {
    var model: ITModelType! { get set }
    var viewDelegate: ITViewType! { get set }
    
    var numberOfItems: Int { get }
    func itObjectForRow(at indexPath: IndexPath) -> ITResponseObject?
}

class ITViewModel: ITViewModelType {
    
    var model: ITModelType! {
        didSet {
            fetchData()
        }
    }
    var viewDelegate: ITViewType!
    
    var itObjects: [ITResponseObject] = []
    
    var numberOfItems: Int {
        return itObjects.count
    }
    
    func itObjectForRow(at indexPath: IndexPath) -> ITResponseObject? {
        if indexPath.row < itObjects.count {
            return itObjects[indexPath.row]
        } else { return nil }
    }
    
    func fetchData() {
        model.fetchImageData { [weak self] (responseArray, errorString) in
            self?.itObjects.append(contentsOf: responseArray)
            self?.viewDelegate.apiResponse(sucess: errorString == nil, error: errorString)
        }
    }
}
