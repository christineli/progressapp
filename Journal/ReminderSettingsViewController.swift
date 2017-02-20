//
//  ReminderSettingsViewController.swift
//  Journal
//
//  Created by Jonah May on 2/12/17.
//  Copyright © 2017 Your School. All rights reserved.
//

import UIKit

class ReminderSettingsViewController: UITableViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerChanged()
        datePicker.datePickerMode = UIDatePickerMode.time
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func setReminder(_ sender: Any) {
        let localNotification = UILocalNotification()
        localNotification.fireDate = datePicker.date
        localNotification.alertBody = "How are you feeling today?"
        localNotification.timeZone = NSTimeZone.default
        localNotification.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
        localNotification.repeatInterval = NSCalendar.Unit.day
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    func datePickerChanged() {
        detailLabel.text = DateFormatter.localizedString(from: datePicker.date, dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.short)
    }
    @IBAction func datePickerValue(_ sender: Any) {
        datePickerChanged()
    }
}
