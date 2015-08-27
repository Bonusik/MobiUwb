//
//  WydzFilolViewController.swift
//  MobiUwb
//
//  Created by jenkins on 20.08.2015.
//  Copyright (c) 2015 Grzegorz Szymański. All rights reserved.
//

import UIKit

class WydzFilolViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "Wydział Filologiczny"
    }
}
