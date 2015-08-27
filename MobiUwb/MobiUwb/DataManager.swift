//
//  DataManager.swift
//  TopApps
//
//  Created by Dani Arnaout on 9/2/14.
//  Edited by Eric Cerney on 9/27/14.
//  Copyright (c) 2014 Ray Wenderlich All rights reserved.
//

import Foundation


let MobiUrlAktualnosci = "http://ii.uwb.edu.pl/serwis/?/json/io"
let MobiUrlZajeciaOdwolane = "http://ii.uwb.edu.pl/serwis/?/json/sz"
let MobiUrlConfig = "http://ii.uwb.edu.pl/mobi/config.xml"
class DataManager {
  
  
  class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
    var session = NSURLSession.sharedSession()
    
    // Use NSURLSession to get data from an NSURL
    let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
      if let responseError = error {
        completion(data: nil, error: responseError)
      } else if let httpResponse = response as? NSHTTPURLResponse {
        if httpResponse.statusCode != 200 {
          var statusError = NSError(domain:"com.raywenderlich", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
          completion(data: nil, error: statusError)
        } else {
          completion(data: data, error: nil)
        }
      }
    })
    
    loadDataTask.resume()
  }

    class func getMobiAktualnosciDataWithSuccess(success: ((MobiUwbData: NSData!) -> Void)) {
        
        loadDataFromURL(NSURL(string: MobiUrlAktualnosci)!, completion: {(data, error) -> Void in
            if let urlData = data {
                
                success(MobiUwbData: urlData)
            }
        })
    }
    
    class func getMobiZajeciaOdwolaneDataWithSuccess(success: ((MobiUwbData: NSData!) -> Void)) {
        
        loadDataFromURL(NSURL(string: MobiUrlZajeciaOdwolane)!, completion: {(data, error) -> Void in
            if let urlData = data {
                
                success(MobiUwbData: urlData)
            }
        })
    }
    class func getMobiUrlConfigWithSuccess(success: ((MobiUwbData: NSData!) -> Void)) {
        
        loadDataFromURL(NSURL(string: MobiUrlConfig)!, completion: {(data, error) -> Void in
            if let urlData = data {
                
                success(MobiUwbData: urlData)
            }
        })
    }


    
    class func checkForNewInformation(jsonArrayData: [MobiUwbModel], lastCheckData: String) -> Bool {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        
        let firstDateFromArray = dateFormatter.dateFromString(jsonArrayData[0].data)
        let storedDate = dateFormatter.dateFromString(lastCheckData)
        
        let day = firstDateFromArray!.compare(storedDate!)
        
        if day == .OrderedDescending {
            return true
        }else{
            return false
        }
    }
    
}
