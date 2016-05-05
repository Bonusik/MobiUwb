//
//  DataManager.swift
//  TopApps
//


import Foundation


let MobiUrlAktualnosci = "http://ii.uwb.edu.pl/serwis/?/json/io"
let MobiUrlZajeciaOdwolane = "http://ii.uwb.edu.pl/serwis/?/json/sz"

class DataManager {
  
  class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
    let session = NSURLSession.sharedSession()
    
    let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
      if let responseError = error {
        completion(data: nil, error: responseError)
      } else if let httpResponse = response as? NSHTTPURLResponse {
        if httpResponse.statusCode != 200 {
          let statusError = NSError(domain:"ii.uwb.edu.pl", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
          completion(data: nil, error: statusError)
        } else {
          completion(data: data, error: nil)
        }
      }
    })
    
    loadDataTask.resume()
  }

    class func getDataFrom(adres:String, withSuccess success: ((MobiUwbData: NSData!)  -> Void)) {
        
        loadDataFromURL(NSURL(string: adres)!, completion: {(data, error) -> Void in
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
