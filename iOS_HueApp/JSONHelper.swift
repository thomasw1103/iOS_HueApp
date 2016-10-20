//
//  JSONHelper.swift
//  iOS_HueApp
//
//  Created by Thomas Woerdeman on 18/10/2016.
//  Copyright © 2016 Thomas Woerdeman. All rights reserved.
//

import Foundation
import Alamofire

class JSONHelper{
    
    static let sharedInstance = JSONHelper()
    //SCHOOL URL: 
    let url = "http://192.168.1.179/api/148e6416399491c7177ea47a29e99edb/lights"
    //THOMAS URL:
    //let url = "http://192.168.142.1:80/api/9a62cc50112f924f16114991f4eb017/lights"
    var lightsArray = [Light]()
    
    
    func recieveLights(completionHandler: @escaping (AnyObject?, NSError?) -> ()){
        fetchAllLights(completionHandler: completionHandler)
    }
    
    func fetchAllLights(completionHandler: @escaping (AnyObject?, NSError?) -> ()){
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default).responseJSON { response in
            
            switch(response.result) {
            case .success(let value):
                completionHandler(value as AnyObject?, nil)
                break;
               
            case .failure(let error):
                completionHandler(nil, error as NSError?)
                break;
            }
        }
    }
    
    func putState(lightObj : Light){
        let requestUrl : String = url + "/" + lightObj.lightId + "/state"
        var request = URLRequest(url: URL(string: requestUrl)!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let values = ["on": lightObj.isOn!, "hue": lightObj.hue!, "bri": lightObj.bri!, "sat": lightObj.sat!] as [String : Any]
        
        do {
          request.httpBody = try JSONSerialization.data(withJSONObject: values)
        } catch {
            print("Error")
        }
        Alamofire.request(request).responseJSON { response in
            switch(response.result) {
            case .success(let value):
                print(value)
                break;
                
            case .failure(let error):
                print(error)
                break;
            }
 }
    }
}
