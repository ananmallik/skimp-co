//
//  ItemsNetworking.swift
//  Skimp
//
//  Created by Anan Mallik on 29/01/2018.
//  Copyright © 2018 Skimp Co. All rights reserved.
//

import Foundation
import Alamofire

//The 'Networking' Class used to retreive JSON data and store into a Dictionary.
class ItemsNetworking
{
    
    func downloadItemDetails(completed: @escaping DownloadComplete)
    {
        
        let itemsURL = URL(string: SERVER_URL)!
        
        Alamofire.request(itemsURL).responseJSON
            {
                response in
                
                let result = response.result
                
                if let dict = result.value as? [Dictionary<String, AnyObject>]
                {
                    
                    GlobalData.sharedInstance.dict = dict
                }
                
                completed()
        }
        
    }
    
}
