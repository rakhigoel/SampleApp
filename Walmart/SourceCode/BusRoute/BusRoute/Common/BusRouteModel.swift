//
//  BusRouteModel.swift
//  BusRoute
//
//  Created by Rakhi goel on 11/16/17.
//  Copyright © 2017 Rakhi goel. All rights reserved.
//

import Foundation

struct RouteDescription : Decodable {
    
    var id: String
    var accessible: Int
    var imageUrl: String
    var name: String
    var description: String
    //var stops: [RouteDetail]
}


struct RouteDetail : Decodable{
    
    var name: String
}


