//
//  Beer.swift
//  SourceryDemo
//
//  Created by Marius Constantinescu on 25/05/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation
import Serializable

struct Beer {
    var id = ""
    var name = ""
    var description = ""
    var label : NSURL?
}

extension Beer:Serializable {
    init(dictionary: NSDictionary?) {
        id          = self.mapped(dictionary, key: "id") ?? id
        name        = self.mapped(dictionary, key: "name") ?? name
        description = self.mapped(dictionary, key: "description") ?? description
        label       = self.mapped(dictionary, key: "label")
    }
    
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        dict["id"]          = id
        dict["name"]        = name
        dict["description"] = description
        dict["label"]       = label
        return dict
    }
}

struct BeerResponse {
    var beers : [Beer] = []
    var currentPage = 0
    var numberOfPages = 0
    var totalResults = 0
}

extension BeerResponse:Serializable {
    init(dictionary: NSDictionary?) {
        beers         = self.mapped(dictionary, key: "data") ?? beers
        currentPage   = self.mapped(dictionary, key: "currentPage") ?? currentPage
        numberOfPages = self.mapped(dictionary, key: "numberOfPages") ?? numberOfPages
        totalResults  = self.mapped(dictionary, key: "totalResults") ?? totalResults
    }
    
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        dict["data"]           = beers.encodableRepresentation()
        dict["currentPage"]    = currentPage
        dict["numberOfPages"] = numberOfPages
        dict["totalResults"]   = totalResults
        return dict
    }
}