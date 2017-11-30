//
//  ViewController.swift
//  BusRoute
//
//  Created by Rakhi goel on 11/15/17.
//  Copyright © 2017 Rakhi goel. All rights reserved.
//
import Foundation
import UIKit

struct UAlertString {
    
    static let KAlertNoNetworkMsg     = "Internet connection appears to be offline"
    static let kAlertHeader           = ""
    static let kAlertOk               = "OK"
    
    static let KAlertOptionCancel     = "Cancel"
    
    static let kAlertTimeOut     = "Request time out."
    
    static let kAlertForYes = "Yes"
    static let kAlertForNO = "No"

}


struct ErrorResult{
    
    static let kBadRequest   = 400
    static let kUnauthorised = 401
    static let kDeactivated = 423
    static let kSearchExceeded = 403
    static let kUnAvailable = 404
    static let kUnProcessableEntity = 422
    static let kConflict = 409
    
}

let kApiUrl = "https://www.mocky.io/v2/5a0b474a3200004e08e963e5"

let kAppTitle = "Routes"
let kDetailTitle = "Route"


//MARK: StoryboardName
struct StoryBoardName {
    
    static let kMain           = "Main"
    
}

