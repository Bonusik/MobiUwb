//
//  Announcement.swift
//  MobiUwb
//
//  Created by Grzegorz Szymański on 19.05.2016.
//  Copyright © 2016 Grzegorz Szymański. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class AnnouncementManager {
    
    static let sharedInstance = AnnouncementManager()
    
    
   private init() {

    }
    
    func sendNotificationIfNewAnnouncementsInCategory(category:String) {
        
        
        dateOfLastAnnouncementsOfCategory(category) { completion in
            if let lastAnnouncementDate = self.parseAnnouncementDate(completion) {
                let lastCheckedDate = self.parseAnnouncementDate("2015-06-12T11:31:14Z")//NSDate()
                let compare = lastAnnouncementDate.compare(lastCheckedDate!)
                if compare == .OrderedDescending {
                    print("YES")
                } else {
                    print("NO")
                }
            }
            
        }

    }
    
    func dateOfLastAnnouncementsOfCategory(category:String,completion:(String?)->Void){
        
        let categoryURL = "http://ii.uwb.edu.pl/serwis/?/json/"+category
        
        Alamofire.request(.GET, categoryURL).responseJSON { response in
            var lastAnnouncement:String?
            var parsedJsonData = [MobiUwbModel]()
            let json = JSON(response.result.value!)
            if let unparsedJsonData = json.array {
                
                
                for dataJson in unparsedJsonData {
                    
                    let daneData: String? = dataJson["data"].string
                    let daneTresc: String? = dataJson["tresc"].string
                    let daneTytul: String? = dataJson["tytul"].string
                    
                    let oneData = MobiUwbModel(data: daneData, tresc: daneTresc, tytul: daneTytul)
                    parsedJsonData.append(oneData)
                }
                
            }
            lastAnnouncement = parsedJsonData[0].data
            completion(lastAnnouncement)

            }
    }
    
    func parseAnnouncementDate(date: String?) -> NSDate? {
        
        if let newDate = date {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        
        let parsedDate = dateFormatter.dateFromString(newDate)
            return parsedDate
        } else {
            return nil
        }
        
    }
}