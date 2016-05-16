//
//  ViewController.swift
//  MobiUwb
//
//  Created by Grzegorz Szymański on 18.08.2015.
//  Copyright (c) 2015 Grzegorz Szymański. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainViewController: UIViewController {

    @IBOutlet weak var WebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var  parsedJsonData = [MobiUwbModel]()
        
//        DataManager.getMobiZajeciaOdwolaneDataWithSuccess { (MobiUwbData) -> Void in
//            let json = JSON(data: MobiUwbData)
//            if let unparsedJsonData = json.array {
//                
//                //pozmieniac nazwy zmiennych
//                for dataJson in unparsedJsonData {
//                    
//                    let daneData: String? = dataJson["data"].string
//                    let daneTresc: String? = dataJson["tresc"].string
//                    let daneTytul: String? = dataJson["tytul"].string
//                    
//                    let oneData = MobiUwbModel(data: daneData, tresc: daneTresc, tytul: daneTytul)
//                    parsedJsonData.append(oneData)
//                }
//                
//            }
//            //print(DataManager.checkForNewInformation(parsedJsonData, lastCheckData: "2015-06-12T11:31:14Z"))
//        }
//        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "Instytut Informatyki"
        
        let URL = NSURL(string: "http://ii.uwb.edu.pl/mobi/?place=ii&client=android")
        WebView.loadRequest(NSURLRequest(URL: URL!))
        WebView.scrollView.bounces = false;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

