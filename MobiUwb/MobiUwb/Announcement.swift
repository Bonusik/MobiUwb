//
//  Announcement.swift
//  MobiUwb
//
//  Created by Grzegorz Szymański on 19.05.2016.
//  Copyright © 2016 Grzegorz Szymański. All rights reserved.
//

import Foundation
import SwiftyJSON

class AnnouncementManager {
    
    static let sharedInstance = AnnouncementManager()
    
   private init() {

    }
    
    func areTheyNewAnnouncementsInCategory(category:String) -> Bool {
        
        let lastAnnouncement:NSDate = parseAnnouncementDate(dateOfLastAnnouncementsOfCategory(category))
        
        let lastCheckedDate:NSDate = NSDate()
        
        let compare = lastAnnouncement.compare(lastCheckedDate)
        
        if compare == .OrderedDescending {
            return true
        }else{
            return false
        }
        
    }
    
    func dateOfLastAnnouncementsOfCategory(category:String)->String {
        
        var parsedJsonData = [MobiUwbModel]()
        let categoryURL = "http://ii.uwb.edu.pl/serwis/?/json/"+category
        DataManager.getDataFrom("http://ii.uwb.edu.pl/mobi/config.xml")  { (MobiUwbData) -> Void in
            let json = JSON(data: MobiUwbData)
            if let unparsedJsonData = json.array {
                
                for dataJson in unparsedJsonData {
                    
                    let daneData: String? = dataJson["data"].string
                    let daneTresc: String? = dataJson["tresc"].string
                    let daneTytul: String? = dataJson["tytul"].string
                    
                    let oneData = MobiUwbModel(data: daneData, tresc: daneTresc, tytul: daneTytul)
                    parsedJsonData.append(oneData)
                }
                
            }
        }
        return parsedJsonData[0].data
        
    }
    
    func parseAnnouncementDate(date: String) -> NSDate {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        
        let parsedDate = dateFormatter.dateFromString(date)
        
        return parsedDate!
        
    }
}