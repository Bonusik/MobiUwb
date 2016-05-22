//
//  SettingsViewController.swift
//  MobiUwb
//
//  Created by Grzegorz Szymański on 18.05.2016.
//  Copyright © 2016 Grzegorz Szymański. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var moreSettingsView: UIView!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var timeButton: UIButton!
    
    @IBOutlet weak var aktualnosciButton: UIButton!
    @IBOutlet weak var zajeciaButton: UIButton!
    @IBOutlet weak var sprawyButton: UIButton!
    @IBOutlet weak var biuroButton: UIButton!
    @IBOutlet weak var szkoleniaButton: UIButton!
    @IBOutlet weak var planButton: UIButton!
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    
    let pickerData = ["1 min.","10 min.","30 min.", "1 godz.", "2 godz.", "6 godz.", "12 godz.", "1 dzień"]
    let userDefault = NSUserDefaults.standardUserDefaults()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewSettings()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "Ustawienia"
        
    }
    
    func setupViewSettings() {
        func initialButtonIcon(button:UIButton, setting:Bool?) {
            if setting == nil{
                button.setImage(UIImage(named: "ic_checkbox.png"), forState: UIControlState.Normal)
            } else if setting == true{
                button.setImage(UIImage(named: "ic_checkbox.png"), forState: UIControlState.Normal)
            } else if setting == false {
               button.setImage(UIImage(named: "ic_uncheckbox.png"), forState: UIControlState.Normal)
            }
        }
        let buttons = ["aktualnosci":aktualnosciButton,"zajecia":zajeciaButton,"sprawy":sprawyButton,"biuro":biuroButton,"szkolenia":szkoleniaButton,"plan":planButton]
        for button in buttons {
           let check = userDefault.boolForKey(button.0)
            initialButtonIcon(button.1, setting: check)
        }
        let userPermission = UIApplication.sharedApplication().currentUserNotificationSettings()
        if userPermission?.types != UIUserNotificationType.None {
            notificationSwitch.on = true
            moreSettingsView.hidden = false
        } else {
            notificationSwitch.on = false
        }
        
        
    }
    
    //MARK:-
    //MARK:Button handlers
    @IBAction func notificationSwitched(sender: UISwitch) {
        
        if sender.on {
            moreSettingsView.hidden = false
        } else {
            moreSettingsView.hidden = true
        }
    }
    
    @IBAction func timeButtonPressed(sender: UIButton) {
        if timePicker.hidden {
            timePicker.hidden = false
        }else {
            timePicker.hidden = true
        }
    }
    
    func updateTimeButton() {
        let pickerRow = timePicker.selectedRowInComponent(0)
        let timeString = pickerData[pickerRow]
        timeButton.setTitle(timeString, forState: UIControlState.Normal)
        
    }
    
    @IBAction func aktualnosciButtonPressed(sender: UIButton) {
        changeImageForButton(sender, setting: "aktualnosci")
    }
    @IBAction func zajeciaButtonPressed(sender: UIButton) {
        changeImageForButton(sender, setting: "zajecia")
    }
    @IBAction func sprawyButtonPressed(sender: UIButton) {
        
        changeImageForButton(sender, setting: "sprawy")
    }
    @IBAction func biuroButtonPressed(sender: UIButton) {

        changeImageForButton(sender, setting: "biuro")
    }
    @IBAction func szkoleniaButtonPressed(sender: UIButton) {

        changeImageForButton(sender, setting: "szkolenia")
    }
    
    @IBAction func planButtonPressed(sender: UIButton) {
        changeImageForButton(sender, setting: "plan")
    }
    func changeImageForButton(button: UIButton, setting: String) {
        let userSetting:Bool? = userDefault.boolForKey(setting)
        if userSetting == false {
            button.setImage(UIImage(named: "ic_checkbox.png"), forState: UIControlState.Normal)
            userDefault.setBool(true, forKey: setting)
        } else if userSetting == true {
            button.setImage(UIImage(named: "ic_uncheckbox.png"), forState: UIControlState.Normal)
            userDefault.setBool(false, forKey: setting)
        } else if userSetting == nil{
            button.setImage(UIImage(named: "ic_checkbox.png"), forState: UIControlState.Normal)
            userDefault.setBool(true, forKey: setting)
        }
        
    }

    
    //MARK:-
    //MARK:Picker DataSource & Delegate
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
         return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let customTitle = NSAttributedString(string: pickerData[row], attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        return customTitle
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateTimeButton()
    }
}