//
//  CreateReminderVC.swift
//  ExampleCodes
//
//  Created by boqian cheng on 2017-10-04.
//  Copyright © 2017 boqiancheng. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications

class CreateReminderVC: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var listTable: UITableView!
    
    var remindersArr: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.listTable.layer.borderWidth = 2.0
        self.listTable.layer.borderColor = UIColor.lightGray.cgColor
        self.listTable.layer.masksToBounds = true
        self.createBtn.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
        self.listTable.dataSource = self
        
        center.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAction(_ sender: Any) {
        self.addReminder()
    }
    
    fileprivate func addReminder() {
        
        let dateFormatString = "yyyy-MM-dd'-'HH:mm"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatString
        let calendarUnit: Set<Calendar.Component> = [.minute, .hour, .day, .month, .year]
        let calendarLocal = Calendar.current
        
        let now = Date()
        guard let threeMinutesAfter = calendarLocal.date(byAdding: .minute, value: 2, to: now) else {
            return
        }
        
        let dateComponents =  calendarLocal.dateComponents(calendarUnit, from: threeMinutesAfter)
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = dateFormatter.string(from: threeMinutesAfter)
        
        content.sound = UNNotificationSound(named: "beep-8.wav")
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let identifier = dateFormatter.string(from: threeMinutesAfter)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { [unowned self] (error) in
            if let error = error {
                // Something went wrong
                print(error)
            } else {
                let newReminder = ["Reminder", dateFormatter.string(from: threeMinutesAfter)]
                self.remindersArr.append(newReminder)
                self.listTable.reloadData()
            }
        })
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound])
        let titleStr = notification.request.content.title
        let bodyStr = notification.request.content.body
        self.presentAlert(aTitle: titleStr, withMsg: bodyStr, confirmTitle: "OK")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func presentAlert(aTitle: String?, withMsg: String?, confirmTitle: String?) {
        
        let alert = UIAlertController(title: aTitle, message: withMsg, preferredStyle: .alert)
        let okAct = UIAlertAction(title: confirmTitle, style: .default, handler: nil)
        alert.addAction(okAct)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    deinit {
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CreateReminderVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.remindersArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath)
        
        // Configure the cell...
        
        let thisReminder = self.remindersArr[indexPath.row] as! [String]
        
        cell.textLabel?.text = thisReminder[0]
        cell.detailTextLabel?.text = thisReminder[1]
        
        return cell
    }
}
