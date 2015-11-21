//
//  AboutProgramViewController.swift
//  MobiUwb
//
//  Created by Grzegorz Szymański on 19.08.2015.
//  Copyright (c) 2015 Grzegorz Szymański. All rights reserved.
//

import UIKit
import SWXMLHash


class AboutProgramViewController: UITableViewController {
    
    var authors = [String]()
    var supervisor:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.getMobiUrlConfigWithSuccess { (MobiUrlData) -> Void in
        let xml = SWXMLHash.parse(MobiUrlData)
            self.supervisor=xml["konfiguracja"]["opiekunowie"]["opiekun"].element!.text!
            for author in 0 ..< xml["konfiguracja"]["autorzy"]["autor"].all.count {
              self.authors.append(xml["konfiguracja"]["autorzy"]["autor"][author].element!.text!)
            }
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.tableView.reloadData()
            }
        }
        
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    //Podzial table view na sekcje
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }

    
    
    //Ustawienie roznych ilosci komorek dla sekcji
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        
        if section == 1 {
            rowCount = authors.count
        } else  {
            rowCount = 1
        }
        return rowCount
    }

    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let headerSection:String
        
        switch section {
        case 0:
            headerSection = "Opiekun"
        case 1:
            headerSection = "Autorzy"
        case 2:
            headerSection = "Licencja"
        case 3:
            headerSection = "Podziękowania"
        default:
            headerSection = ""
        }
        return headerSection
    }

//    //Wypelnienie kolejnych komorek danymi
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: BaseTableViewCell = tableView.dequeueReusableCellWithIdentifier("authorsCell") as! BaseTableViewCell
        
        switch indexPath.section {
            
        case 0:
            
            cell.aboutLabel.text = supervisor
            cell.aboutIcon.image = UIImage(named: "OpiekunIcon")
        case 1:
            
            cell.aboutLabel.text = authors[indexPath.row]
            cell.aboutIcon.image = UIImage(named: "AutorIcon")
        case 2:
            
            cell.aboutLabel.text = "Program na licencji MIT"
        case 3:
            
            cell.aboutLabel.text = "Autorzy pragną podziękować wszystkim członkom Informatycznego Koła Naukowego UwB oraz dyrekcji Instytutu Informatyki"
        default:
            break
        }
         return cell
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "About Program"
    }
    
}