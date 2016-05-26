//
//  ConnectionManager.swift
//  SourceryDemo
//
//  Created by Marius Constantinescu on 24/05/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import UIKit
import Alamofire
import Serializable

struct ConnectionManager {
    
    static let manager:Manager = Manager(configuration: ConnectionManager.configuration())
    
    static func configuration() -> NSURLSessionConfiguration {
        let staticHeaders = ["Content-Type" : "application/json"]
        let configuration = Manager.sharedInstance.session.configuration
        configuration.timeoutIntervalForRequest = 15.0
        configuration.HTTPAdditionalHeaders = staticHeaders
        return configuration
    }
    
    //TODO: add your key here
    static let key = "Get your key from http://www.brewerydb.com/developers/docs. Create an account and get the key"

}


extension ConnectionManager {

    static func fetchBeers(page: Int, completion: (result:Response<BeerResponse, NSError>) -> Void) {
        let url = "https://api.brewerydb.com/v2/beers"
        let parameters = ["key" : key, "styleId" : "58", "p" : String(page)]
        manager.request(.GET, url, parameters: parameters).responseSerializable(completion)
    }
}