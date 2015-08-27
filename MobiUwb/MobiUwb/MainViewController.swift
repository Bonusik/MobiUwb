//
//  ViewController.swift
//  MobiUwb
//
//  Created by Grzegorz Szymański on 18.08.2015.
//  Copyright (c) 2015 Grzegorz Szymański. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var WebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var  parsedJsonData = [MobiUwbModel]()
        
        DataManager.getMobiZajeciaOdwolaneDataWithSuccess { (MobiUwbData) -> Void in
            let json = JSON(data: MobiUwbData)
            if let unparsedJsonData = json.array {
                
                
                for dataJson in unparsedJsonData {
                    
                    var daneData: String? = dataJson["data"].string
                    var daneTresc: String? = dataJson["tresc"].string
                    var daneTytul: String? = dataJson["tytul"].string
                    
                    var oneData = MobiUwbModel(data: daneData, tresc: daneTresc, tytul: daneTytul)
                    parsedJsonData.append(oneData)
                }
                
            }
            println(DataManager.checkForNewInformation(parsedJsonData, lastCheckData: "2015-06-12T11:31:14Z"))
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "Instytut Informatyki"
        
        var URL = NSURL(string: "http://ii.uwb.edu.pl/mobi/?place=ii&client=android")
        WebView.loadRequest(NSURLRequest(URL: URL!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

