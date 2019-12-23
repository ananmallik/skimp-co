//
//  GlobalData.swift
//  Skimp
//
//  Created by Anan Mallik on 29/01/2018.
//  Copyright © 2018 Skimp Co. All rights reserved.
//

import Foundation

//Singleton class to store Dictionary of Items:
class GlobalData
{
    
    static let sharedInstance = GlobalData()
    var dict : [Dictionary<String, AnyObject>]
    
    private init()
    {
        print("Singleton initialized")
        dict = []
    }
    
}

