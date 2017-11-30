//
//  CTUtility.swift
//  CaltrainWorkOrderSolution
//
//  Created by Rakhi goel on 6/9/17.
//  Copyright © 2017 Rakhi goel. All rights reserved.
//

import UIKit
import Foundation

class BRUtility: NSObject {
    
    static func appDelegateSharedInstance() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
        
    }

    class func controllerForClass(name: String,  storyBoardName:String) -> UIViewController
    {
        let identifier: String  = name
        let viewController:UIViewController = UIStoryboard(name: storyBoardName , bundle: nil).instantiateViewController(withIdentifier: identifier as String) as UIViewController
        
        return viewController
    }

}
