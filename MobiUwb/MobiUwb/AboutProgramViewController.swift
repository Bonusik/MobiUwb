//
//  AboutProgramViewController.swift
//  MobiUwb
//
//  Created by Grzegorz Szymański on 19.08.2015.
//  Copyright (c) 2015 Grzegorz Szymański. All rights reserved.
//

import UIKit

class AboutProgramViewController: UIViewController {
    
    var autors:[String]=[]
    
    @IBOutlet weak var tableView: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.getMobiUrlConfigWithSuccess { (MobiUrlData) -> Void in
        let xml = SWXMLHash.parse(MobiUrlData)
            self.autors.append(xml["konfiguracja"]["opiekunowie"]["opiekun"].element!.text!)
            for autor in 0 ..< xml["konfiguracja"]["autorzy"]["autor"].all.count {
              self.autors.append(xml["konfiguracja"]["autorzy"]["autor"][autor].element!.text!)
            }
            println(xml["konfiguracja"]["autorzy"]["autor"].all.count)
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }
    func numberOfSectionInTableView(tableView: UITableView) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if section == 1 {
            rowCount = autors.count
        } else  {
            rowCount = 1
        }
        return rowCount
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) ->UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("headerCell") as! HeaderTableViewCell
        if section == 0 {
            headerCell.headerTitle.text = "Opiekun"
        }else if section == 1 {
            headerCell.headerTitle.text = "Autorzy"
        }else if section == 2 {
            headerCell.headerTitle.text = "Licencja"
        }else if section == 3 {
            headerCell.headerTitle.text = "Podziękowania"
        }
        return headerCell
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: BaseTableViewCell = tableView.dequeueReusableCellWithIdentifier("baseTableViewCell") as! BaseTableViewCell
            cell.autorLabel.text = "Dominik"
            cell.autorIcon.image = UIImage(named: "OpiekunIcon")
            return cell
        }
//        if (indexPath.row < autors.count) {
//            let cell: BaseTableViewCell = tableView.dequeueReusableCellWithIdentifier("baseTableViewCell") as! BaseTableViewCell
//            cell.autorLabel.text = autors[indexPath.row]
//            cell.autorIcon.image = UIImage(named: "OpiekunIcon")
//            tableView.tableFooterView = UIView(frame: CGRectZero)
//            return cell
//        } else if (indexPath.row == autors.count) {
//            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("licencja") as! UITableViewCell
//            return cell
//        } else if (indexPath.row == autors.count+1) {
//            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("podziekowania") as! UITableViewCell
//            return cell
//        }
        let cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        return cell
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "About Program"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}